class ChatSession < ActiveRecord::Base
  belongs_to :site

  validates :name, presence: true
  validates :site, presence: true
  validates :scheduled_for, presence: true

  enum status: [
    :scheduled,
    :open,
    :archived
  ]

  default_scope { order(:scheduled_for) }
end
