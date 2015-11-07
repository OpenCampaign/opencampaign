source 'https://rubygems.org'

gem 'airbrake'
gem 'acts_as_list'
gem 'acts_as_taggable_on'
gem 'attr_extras'
gem 'awesome_nested_set', '~> 2.1.6'
gem 'bootstrap-sass', '~> 3.1.1'
gem 'bcrypt-ruby', '3.1.2'
gem 'dotenv'
gem 'dotenv-rails'
gem 'font-awesome-sass'
gem 'high_voltage', '~> 2.1.0'
gem 'jquery-rails'
gem 'log4r'
gem 'markdown-rails'
#TODO: Replace markerb with maildown with Rails 4
gem 'markerb'
gem 'omniauth'
gem 'omniauth-identity'
gem 'pg' # Abstract based on detenv setting
gem 'puma'
gem 'pundit'
gem 'rails', '~> 4.2'
gem 'redcarpet', '>= 2.0'
gem 'rolify'
gem 'sass-rails'
gem 'state_machine'
gem 'toml-rb'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'brakeman', require: false
end

group :development do
  gem 'awesome_print'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'foreman'
  gem 'pry-rails'
end

group :test do
  gem 'aruba'
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'rack_session_access'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'simplecov', require: false
  gem 'vcr'
  gem 'webmock'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails'
  gem 'uglifier', '>= 1.0.3'
  # node.js is installed on my servers no need to worry about therubyracer, etc.
end
