environment ENV['RACK_ENV'] || 'development'

if ENV['HEROKU']
  workers Integer(ENV['WEB_CONCURRENCY'] || 2)
  threads_count = Integer(ENV['MAX_THREADS'] || 5)
  threads threads_count, threads_count

  preload_app!

  rackup      DefaultRackup
  port        ENV['PORT']     || 3000

  on_worker_boot do
    # Worker specific setup for Rails 4.1+
    # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
    ActiveRecord::Base.establish_connection
  end
else
  # Change to match your CPU core count
  workers 1

  # Min and Max threads per worker
  threads 1, 6

  app_dir = File.expand_path('../..', __FILE__)
  shared_dir = '/var/www/bed_management/shared'

  daemonize

  # Set up socket location
  bind "unix://#{shared_dir}/sockets/puma.sock"

  # Logging
  stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true

  # Set master PID and state locations
  pidfile "#{shared_dir}/pids/puma.pid"
  state_path "#{shared_dir}/pids/puma.state"
  activate_control_app

  on_worker_boot do
    require 'active_record'
    ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
    ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
  end
end