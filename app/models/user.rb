class User < ActiveRecord::Base
  has_secure_password
  belongs_to :site
  belongs_to :access_level

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

end
