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
end
