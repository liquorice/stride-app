class ShortenedUrl < ApplicationRecord

  def self.shorten(url)
    # Check cache to see if URL has already been shortened
    existing = find_by(long_url: url)
    return existing.short_url if existing

    escaped_url = URI::escape(url)
    short_url = open("https://api-ssl.bitly.com/v3/shorten?access_token=#{Rails.configuration.bitly_token}&longUrl=#{escaped_url}&format=txt").read

    short_url.strip!

    create(
      long_url: url,
      short_url: short_url
    )

    return short_url
   end

end
