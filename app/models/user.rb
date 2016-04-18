class User < ActiveRecord::Base
  # --- Associations ---
  belongs_to :site
  belongs_to :access_level
  has_many :topic_threads
  has_many :posts

  # --- Validations ---
  has_secure_password
  validates :name, presence: true, length: { minimum: 2 }
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
  validates :avatar_colour, inclusion: { in: AvatarHelper.avatar_colours }
  validates :avatar_face, inclusion: { in: AvatarHelper.avatar_faces}

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

  def update_last_seen
    update(last_seen: Time.now)
  end

end
