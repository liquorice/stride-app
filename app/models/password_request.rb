class PasswordRequest < ApplicationRecord
  belongs_to :user

  before_validation :assign_token

  private

  def assign_token
    self.token ||= SecureRandom.urlsafe_base64
  end

end
