module MailerHelper

  def public_url(path)
    "http://#{@host}#{path}"
  end

end