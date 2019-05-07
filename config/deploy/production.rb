server '52.63.26.76', user: 'ubuntu', roles: %w{web app}

set :full_app_name, "#{fetch(:application)}-#{fetch(:stage)}"

set :deploy_to, "/var/www/stride-production"

set :unicorn_config_path, '/var/www/stride-production/current/config/unicorn/production.rb'
set :unicorn_pid, '/var/www/stride-production/shared/tmp/unicorn-production.pid'

set :branch, 'production'

set :pty, true
set :ssh_options, {
  forward_agent: true,
  keys: %w[~/.ssh/stride-a.pem]
}