# config valid only for Capistrano 3.1
lock '3.7.1'

require 'yaml'
settings = YAML.load(File.read(File.expand_path('../application.yml', __FILE__)))['development']

#set :flowdock_api_token, settings['flowdock']['flowdock_api_token']
#set :flowdock_project_name, settings['flowdock']['flowdock_project_name']
#set :flowdock_deploy_tags, settings['flowdock']['flowdock_deploy_tags']

set :application, '5xruby_tw'
set :repo_url, 'git@github.com:5xRuby/5xruby.tw.git'
set :branch, 'master'
set :bundle_binstubs, false

set :linked_files, %w{config/database.yml config/application.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}



# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

after :'deploy:publishing', :'deploy:restart'
namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
#      execute "cd #{release_path} && (PATH=/usr/local/ruby20/bin:$PATH RAILS_ENV=#{fetch(:rails_env)} bundle exec rake resque:restart > /dev/null)"
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
#      within release_path do
#        with rails_env: fetch(:rails_env) do
#          execute :rake, 'flowdock:notify'
#        end
#      end
    end
  end

  after :finishing, 'deploy:cleanup'

end
