class Site < ActiveRecord::Base
  has_many :access_levels
  has_many :topics
  has_many :topic_threads, through: :topics
  has_many :posts, through: :topic_threads
  has_many :users
  has_many :password_requests, through: :users

  def self.find_by_host(host)
    # Helper function that searches the host array for a matching site
    matches = where('? = ANY (hosts)', host)
    matches.any? ? matches.first : nil
  end

end
