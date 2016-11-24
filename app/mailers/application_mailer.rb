class ApplicationMailer < ActionMailer::Base
  helper MailerHelper

  default from: 'notifications@#{@host}'
  layout 'mailer'
end
