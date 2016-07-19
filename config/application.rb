require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module StrideApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.time_zone = 'Melbourne'

    # Custom autoload paths
    config.autoload_paths << Rails.root.join('lib', 'modules')
    config.autoload_paths << Rails.root.join('lib', 'classes')
    config.autoload_paths << Rails.root.join('lib', 'classes', 'liblib')
    config.autoload_paths << Rails.root.join('app', 'validators')

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Use Amazon SES for mailing
    config.action_mailer.delivery_method = :aws_sdk

    # For SMS sending
    config.smsbroadcast_username = "liquoricestudio"
    config.smsbroadcast_password = "XTMVL66}"

    # For URL shortening
    config.bitly_token = "848d95b7e3a57d0b825a4d3ce1b8967904225224"

    # For Twitter DMs

    config.twitter_credentials = {
      "pete" => {
        consumer_key: "dPlcPlHqXWNKHHZaiYA4McesO",
        consumer_secret: "jK6dfjovKYYfE4CnbvJF9EgQA3FYCwu3PR1hhUseiwZJ5q2YXI",
        access_token: "746147183762636801-acAtW3Okcuik05QWX6ZOEqsEB8VbRbN",
        access_token_secret: "OWjK7Z00UGhSyPAPB8DiJrxdSsX7WfgCeppp5ym8aJyLg"
      },
      "dale" => {
        consumer_key: "tCd6uihRWwwGpSTT1DMYR9P54",
        consumer_secret: "fLgJK9sznmRYRQDSty7wCBP7WOh7EDoVLYxLQNdR54Owq60tH0",
        access_token: "746149994650959872-E53HEsqRiaFlBo8IBWhJr7DT6hElOmn",
        access_token_secret: "hCY2pxeKqtLgbs5r76U4qJPxDfX4C3IzdISeyeoILe0PV"
      }
    }

  end
end
