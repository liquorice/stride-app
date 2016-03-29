class Post < ActiveRecord::Base
  belongs_to :topic_thread
  belongs_to :user

  default_scope { order(created_at: :asc) }

  self.per_page = 8
end
