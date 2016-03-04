class Site < ActiveRecord::Base

  def self.find_by_host(host)
    # Helper function that searches the host array for a matching site
    matches = where('? = ANY (hosts)', host)
    matches.any? ? matches.first : nil
  end

end
