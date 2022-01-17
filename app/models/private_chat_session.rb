class PrivateChatSession < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  has_many :chat_messages
  belongs_to :chat_session

  scope :since, ->(id) {
    order(created_at: :asc).where("id > ?", id)
  }

  scope :for_user, ->(user) {
    where("user_id = ? OR moderator_id = ?", user.id, user.id)
  }

  enum status: [
    :open,
    :archived
  ]

  def participants
    User.where(
      id: participant_ids
    )
  end

  def participant_ids
    [
      moderator_id,
      user_id
    ]
  end

  def moderator
    User.find(moderator_id)
  end

  def end
    update(
      ended_at: Time.now,
      status: :archived
    )
  end

  def to_data
    {
      id: id,
      timestamp: created_at,
      content: message,
      type: "notification",
      user_id: moderator.id,
      user_name: moderator.name,
      user_path: moderator.path,
      avatar_colour: moderator.processed_avatar_colour,
      avatar_face: moderator.avatar_face,
      user_type: "(moderator)"
    }
  end

  def message
    [
      "Hi #{user.name}, #{moderator.name} would like to chat to you privately. ",
      "<a href=#{self.path} target='_blank'>Follow this link</a> ",
      "to chat in a new window"
    ].join
  end

  def path
    private_chat_path(self)
  end

end
