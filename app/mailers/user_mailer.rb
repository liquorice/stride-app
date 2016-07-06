class UserMailer < ApplicationMailer

  def password_reset(host, user, reset_url)
    @host = host
    @user = user
    @reset_url = reset_url
    to = @user.email
    mail(
      to: to,
      subject: 'Password reset request',
      from: "password_reset@#{@host}"
    )
  end

end
