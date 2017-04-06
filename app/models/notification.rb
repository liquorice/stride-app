class Notification < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :user
  validates :user, presence: true

  enum status: [
    :sending,
    :sent
  ]

  default_scope { order(created_at: :desc) }

  def site
    user.site
  end

  def self.content_types
    [
      :scheduled_chat_content,
      :today_chat_content,
      :new_article_content
    ]
  end

  def self.scheduled_chat_content(site, options = {})
    chat_session = ChatSession.find_by(id: options[:chat_session_id]) || ChatSession.new(
      discreet_name: '<discreet name>',
      scheduled_for: Time.now
    )

    link = chat_session.id ? ShortenedUrl.shorten(chat_session.public_path) : "<link>"

    %{
      There's a live chat about #{chat_session.discreet_name} that might
      interest you on #{chat_session.scheduled_for_date} at
      #{chat_session.scheduled_for_time}. To find out more: #{link}
    }.gsub(/\s+/, " ")
  end

  def self.today_chat_content(site, options = {})
    chat_session = ChatSession.find_by(id: options[:chat_session_id]) || ChatSession.new(
      discreet_name: '<discreet name>',
      scheduled_for: Time.now
    )

    link = chat_session.id ? ShortenedUrl.shorten(chat_session.public_path) : "<link>"

    %{
      Today's live chat discussion about #{chat_session.discreet_name}
      will begin at at #{chat_session.scheduled_for_time}.
      To find out more: #{link}
    }.gsub(/\s+/, " ")
  end

  def self.new_article_content(site, options = {})
    if options[:article_data]
      article_url, discreet_subject = options[:article_data].split("|", 2)
      article_link = ShortenedUrl.shorten(article_url)
    else
      discreet_subject = "<discreet description>"
      article_link = "$link"
    end

    %{
      There's a new article that might interest you.
      View it here: #{article_link}
    }.gsub(/\s+/, " ")
  end

  def self.subject_title_for_data(data)
    if data[:article_data]
      data[:article_data].split("|", 2)[1]
    elsif data[:chat_session_id]
      ChatSession.find_by(id: data[:chat_session_id]).try(&:name)
    end
  end

  def dispatch(host)
    # Only run on unsent messages
    return if sent?

    # Email notification
    site.users.where(email_opted_in: true).each do |user|
      UserMailer.notification(
        host,
        user,
        content
      ).deliver_now
      update(email_count: email_count + 1)
    end

    # SMS notifications
    numbers = site.users.where(sms_opted_in: true).pluck(:sms_contact)

    # Remove any non-numeric chars
    to_numbers = numbers.map{|n| n.tr("^0-9", "") }.join(",")
    escaped_content = ERB::Util.url_encode(content)

    sms_api_url = [
      "https://api.smsbroadcast.com.au/api-adv.php?",
      "username=#{Rails.configuration.smsbroadcast_username}&",
      "password=#{ERB::Util.url_encode(Rails.configuration.smsbroadcast_password)}&",
      "to=#{to_numbers}&",
      "from=#{site.pretty_name}&",
      "message=#{escaped_content}&",
      "maxsplit=3"
    ].join()

    open(sms_api_url).read
    update(sms_count: numbers.count)

    # Twitter notification
    credentials = Rails.configuration.twitter_credentials[site.name]
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = credentials[:consumer_key]
      config.consumer_secret = credentials[:consumer_secret]
      config.access_token = credentials[:access_token]
      config.access_token_secret = credentials[:access_token_secret]
    end

    site.users.where(twitter_opted_in: true).each do |user|
      client.create_direct_message(user.twitter_contact, content)
      update(twitter_count: twitter_count + 1)
    end

    # Update status
    update(status: :sent)
  end

end
