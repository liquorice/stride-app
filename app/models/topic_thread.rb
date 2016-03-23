class TopicThread < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :posts

  scope :preview, -> { where(public: true).limit(4) }

  default_scope { order(pinned: :desc) }

  self.per_page = 8

  def posts_count
    posts.count
  end
end
