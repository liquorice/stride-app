class ApplicationMailer < ActionMailer::Base
  helper MailerHelper

  # TODO: Change to correct address
  default from: 'dev@liquoricestudio.com'
  layout 'mailer'
end
