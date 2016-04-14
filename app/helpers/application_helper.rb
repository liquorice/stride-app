module ApplicationHelper
  def insert_svg filename, options={}
    file = File.read(Rails.root.join('app', 'assets', 'images', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css "svg"
    if options[:class].present?
      svg["class"] = options[:class]
    end
    raw doc
  end

  # def inline_svg(path)
  #   raw Rails.application.assets.find_asset(path).to_s
  # end

  def time_since_post postTime
    secDiff = (Time.now.utc - postTime).floor
    minDiff = (secDiff/60).floor
    if minDiff == 0
      return "#{secDiff}s"
    end
    hourDiff = (minDiff/60).floor
    if hourDiff == 0
      return "#{minDiff}m"
    end
    dayDiff = (hourDiff/24).floor
    if dayDiff == 0
      return "#{hourDiff}h"
    end
    return "#{dayDiff}d"
  end

  def time_created_post postTime
    secDiff = (Time.now.utc - postTime).floor
    minDiff = (secDiff/60).floor
    if minDiff == 0
      return "#{secDiff}s ago"
    end
    hourDiff = (minDiff/60).floor
    if hourDiff == 0
      return "#{minDiff}m ago"
    end
    dayDiff = (hourDiff/24).floor
    if dayDiff == 0
      return "#{hourDiff}h ago"
    end
    weekDiff = (dayDiff/7).floor
    if weekDiff == 0
      return "#{dayDiff}d ago"
    end
    return postTime.strftime("%d %b %y")
  end

end
