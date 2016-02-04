# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'bed_management'
set :repo_url, 'git@github.com:mhaii/BedManagement.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  after :finished, :post_deploy do
    on roles(:app), in: :sequence, wait: 5 do |host|
      within release_path do
        # post scripts
        execute :python3, "scripts/bower.py"
        execute :python3, "scripts/make_and_migrate.py"
        execute :python3, "scripts/collect_static.py"
        execute :python3, "scripts/import_fixture.py"
        execute :python3, "scripts/i18n.py"
        # restart gunicorn
        execute :bash, "gunicorn.sh restart 0"        
      end
    end
  end

end
