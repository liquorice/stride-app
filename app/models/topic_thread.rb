class TopicThread < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  scope :preview, -> { where(public: true).limit(4) }

  default_scope { order(pinned: :desc) }
end
