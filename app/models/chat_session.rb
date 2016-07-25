class ChatSession < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  include ApplicationHelper

  belongs_to :site
  has_many :chat_messages
  has_many :private_chat_sessions

  validates :name, presence: true
  validates :discreet_name, presence: true
  validates :site, presence: true
  validates :scheduled_for, presence: true

  enum status: [
    :scheduled,
    :open,
    :archived
  ]

  default_scope { order(:scheduled_for) }

  self.per_page = 8

  def self.for_tag(tag)
    where("? = ANY (tags)", tag)
  end

  def self.for_query(query)
    where("name ilike ? or description ilike ?", "%#{query}%", "%#{query}%")
  end

  def public_path
    link_to_app(chat_session_path(self), site)
  end

  def start(moderator_user)
    update(
      scheduled_for: Time.now,
      started_at: Time.now,
      status: :open,
      moderator_id: moderator_user.id
    )
  end

  def end
    update(
      ended_at: Time.now,
      status: :archived
    )
  end

  def self.date_format
    "%a, %e %b %Y"
  end

  def self.time_format
    "%l:%M %p"
  end

  def self.scheduled_for_from_date_and_time(date, time)
    Time.zone.parse("#{date} #{time}")
  end

  def scheduled_for_date
    scheduled_for.strftime(ChatSession.date_format)
  end

  def scheduled_for_time
    scheduled_for.strftime(ChatSession.time_format).strip
  end

  def messages_count
    chat_messages.count
  end

  def participants_count
    chat_messages.pluck(:user_id).uniq.count
  end

  def private_chat_participants
    site.users.where(id: private_chat_sessions.map(&:user_id))
  end

  def moderator
    site.users.find_by(id: moderator_id)
  end

  def duration
    return false unless archived?
    ended_at - started_at
  end

  def export_to_json
    {
      id: id,
      name: name,
      scheduled_for: scheduled_for.to_i,
      description: description,
      status: status.humanize,
    }
  end
end
