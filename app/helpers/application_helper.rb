module ApplicationHelper

  def insert_svg(filename, options={})
    file = File.read(Rails.root.join('app', 'assets', 'images', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css "svg"
    if options[:class].present?
      svg["class"] = options[:class]
    end
    raw doc
  end

  def user_last_active(last_seen)
    last_seen_time = Time.at(last_seen.beginning_of_day).to_date
    current_time = Time.at(Time.now.beginning_of_day).to_date

    if last_seen_time === current_time
      return "Today"
      end
    if last_seen_time === (current_time - 1)
      return "Yesterday"
      end
    last_seen.strftime('%d/%m/%y')
  end

  def link_to_kb(path)
    kb_path = Rails.configuration.kb_path.gsub('%', @site.name)
    "#{kb_path}/#{path}"
  end

  def distance_of_future_time_in_words(time)
    # Returns the distance in words between now and a future time
    # If the supplied time has already passed, treat the event as imminent
    time = [Time.now, time].max
    distance_of_time_in_words(time, Time.now, include_seconds: true).gsub('about ','').gsub('less than ','').gsub('seconds','sec')
  end

end
