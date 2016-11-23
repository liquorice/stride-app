class UserMailer < ApplicationMailer

  def password_reset(host, user, reset_url)
    @host = host
    @user = user
    @reset_url = reset_url
    to = @user.email
    
    mail(
      to: to,
      subject: 'Password Reset Request',
      from: "#{@user.site.name.capitalize} <password_reset@#{@host}>"
    )
  end

  def notification(host, user, content)
    @host = host
    @user = user
    @content = content
    @site = user.site
    to = @user.email

    mail(
      to: to,
      subject: "Notification from #{@site.pretty_name}",
      from: "#{@site.pretty_name} <notifications@#{@host}>"
    )
  end


end
