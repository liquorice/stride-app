class User < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  # --- Associations ---
  belongs_to :site
  belongs_to :access_level
  has_many :topic_threads
  has_many :posts
  has_many :password_requests
  has_many :chat_messages
  has_many :notifications

  default_scope { order(created_at: :desc) }
  scope :active, -> { where(suspended: false) }

  # --- Validations ---
  has_secure_password
  validates :name, presence: true, length: { minimum: 2 }, uniqueness: { scope: :site }, username: true
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true, allow_blank: false
  validates :avatar_colour, inclusion: { in: AvatarHelper.avatar_colours }
  validates :avatar_face, inclusion: { in: AvatarHelper.avatar_faces}
  before_validation :ensure_valid_avatar_details

  # --- Access and permissions ---

  def permissions
    # The users permissions are inherited from their access_level
    @user_permissions ||= access_level.try(:permissions) || {}
  end

  def can?(permission)
    # Checks that a user has the permission privledge, as set
    # by their access_level
    # Superusers always have permission
    superuser || permissions.key?(permission.to_s)
  end

  def can_set_access_level?(level)
    return true if superuser
    level.ordinal <= self.access_level.ordinal
  end

  def update_last_seen
    update(last_seen: Time.now)
  end

  def send_password_reset(host)
    request = password_requests.create
    reset_url = password_reset_path(request.token)
    UserMailer.password_reset(host, self, reset_url).deliver_now!
  end

  # --- Avatar ---

  def ensure_valid_avatar_details
    # The special avatar colour "0" would fail validation,
    # so save a different value for these users so validation passes,
    if self.can?(:special_avatar) && AvatarHelper.avatar_colours.exclude?(avatar_colour)
      self.avatar_colour = AvatarHelper.avatar_colours.first
    end
  end


  def processed_avatar_colour
    # If a user can special_avatar, then send the special colour "0"
    # otherwise, use the saved value
    if self.can?(:special_avatar)
      0
    else
      avatar_colour
    end
  end

  #

  def path
    user_path(self)
  end

end
