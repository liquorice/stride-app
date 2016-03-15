class Topic < ActiveRecord::Base
  belongs_to :site
  has_many :topic_threads
  validates :name, presence: true
  validates :site, presence: true

  default_scope { order(:name) }

end
