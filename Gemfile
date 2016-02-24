source 'https://rubygems.org'

gem 'rake', '10.5.0'
gem 'rails', '4.2.4'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'mysql2', '~> 0.3.20'

gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'sass-rails', '~> 5.0'
gem 'slim-rails'

# Use rails-assets instead of bower
source 'https://rails-assets.org' do
  gem 'rails-assets-angular'
  gem 'rails-assets-angular-resource'
  gem 'rails-assets-angular-translate'
  gem 'rails-assets-angular-translate-loader-static-files'
  gem 'rails-assets-angular-ui-router'
  gem 'rails-assets-angularjs-humanize'
  gem 'rails-assets-bootstrap-material-design'
end
# Allow angular to access templates from Rails pipeline
gem 'angular-rails-templates'
gem 'angular_rails_csrf'

gem 'jquery-rails'
gem 'bootstrap', '>= 4.0.0.alpha3'
gem 'font-awesome-sass'

gem 'jbuilder', '~> 2.0'

gem 'bcrypt', '~> 3.1.7'
# gem 'unicorn'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails', '~> 3.0'
  gem 'jasmine'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'capistrano-rails'
  gem 'spring'
  gem 'web-console', '~> 2.0'
end

