def next?
  File.basename(__FILE__) == "Gemfile.next"
end
source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2'
gem 'pg'
gem 'bootsnap'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Slim, for slimness
gem "slim-rails"
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Auto prefixer for Rails
gem "execjs", '< 2.7'
gem "autoprefixer-rails", '9.8.6'

# For uglifier, mebbe?
# gem 'therubyracer', platforms: :ruby
# gem 'libv8'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Mini_magick for image processing
gem "mini_magick"

# Use Unicorn as the app server
gem 'unicorn'

gem 'will_paginate', '~> 3.0.6'

# Use Capistrano for deployment
gem 'capistrano', '3.4.0'
gem 'capistrano-rails', group: :development
gem 'capistrano-rbenv', '~> 2.0'
gem 'capistrano3-unicorn'

# AWS tools for email sending with Amazon SES
gem 'aws-sdk-rails', '~> 1.0'

# For tracking views on forum threads
gem 'impressionist', '~>1.6.1'
gem 'dotenv', groups: [:development, :test]
gem "recaptcha", require: "recaptcha/rails"
gem 'rack-cors'
gem "twitter"
gem 'rspec-rails'

gem 'puma'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'listen'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Nicer errors
  gem 'better_errors'
  gem 'binding_of_caller'
end

