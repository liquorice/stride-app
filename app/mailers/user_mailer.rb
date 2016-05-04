class UserMailer < ApplicationMailer

  def password_reset(host, user, reset_url)
    @host = host
    @user = user
    @reset_url = reset_url
    # to = @user.email
    # TODO change this to the users email once Amazon SES sending is approved
    mail(to: 'dev@liquoricestudio.com', subject: 'Password reset request')
  end

end
