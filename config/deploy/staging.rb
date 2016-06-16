server '52.63.26.76', user: 'ubuntu', roles: %w{web app}

set :full_app_name, "#{fetch(:application)}-#{fetch(:stage)}"

set :deploy_to, "/var/www/stride-staging"

set :unicorn_config_path, '/var/www/stride-staging/current/config/unicorn/staging.rb'
set :unicorn_pid, '/var/www/stride-staging/shared/tmp/unicorn-staging.pid'

set :branch, 'staging'