# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'stride-app'

set :repo_url, 'git@bitbucket.org:liquoricestudio/stride-app.git'
set :rbenv_ruby, '2.0.0-p481'

set :default_env, { path: "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH" }

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp')

namespace :deploy do

  after :restart, :clear_cache do
    # invoke 'unicorn:restart'
  end

end
