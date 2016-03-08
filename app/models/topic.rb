class Topic < ActiveRecord::Base
  belongs_to :site
  validates :name, presence: true
  validates :site, presence: true

  default_scope { order(:name) }

end
