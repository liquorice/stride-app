class ChatMessage < ActiveRecord::Base
  belongs_to :chat_session
  belongs_to :user

  default_scope { order(created_at: :asc) }

end
