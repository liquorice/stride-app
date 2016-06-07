class ChatSession < ActiveRecord::Base
  belongs_to :site
  has_many :chat_messages

  validates :name, presence: true
  validates :site, presence: true
  validates :scheduled_for, presence: true

  enum status: [
    :scheduled,
    :open,
    :archived
  ]

  default_scope { order(:scheduled_for) }

  self.per_page = 8

  def start
    update(
      started_at: Time.now,
      status: :open
    )
  end

  def end
    update(
      ended_at: Time.now,
      status: :archived
    )
  end

  def message_data_since(time)
    chat_messages.joins(:user).where('chat_messages.created_at > ?', Time.at(time)).pluck(:content, :name, :created_at)
  end

  def messages_count
    chat_messages.count
  end

  def participants_count
    chat_messages.pluck(:user_id).uniq.count
  end

  def duration
    return false unless archived?
    ended_at - started_at
  end
end
