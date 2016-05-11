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
  end
end
