class ChatMessage < ActiveRecord::Base
  belongs_to :chat_session
  belongs_to :user

  default_scope { visible.order(created_at: :asc) }

  scope :since, ->(id) {
    order(created_at: :asc).where("id > ?", id)
  }

  scope :visible, -> {
    where(visible: true)
  }


  scope :for_user, ->(user) {
    where.not(user: user)
  }

  def to_data
    {
      id: id,
      content: content,
      user_name: user.name,
      user_id: user.id,
      avatar_colour: user.processed_avatar_colour,
      avatar_face: user.avatar_face
    }
  end

end