source 'https://rubygems.org'

ruby '2.2.2'

gem 'rails'
gem 'rails-api' # Rails for API only applications
gem 'pg' # postgresql database for Active Record
gem 'devise' # user authentication services
gem 'active_model_serializers' # ActiveModel::Serializer implementation
gem 'database_cleaner' # strategies for cleaning your database in Ruby
gem 'method_man' # Defines a MethodObject class
gem 'yelp' # For yelp api
gem 'rack-cors' # Allow Ionic to make calls to API
gem 'paperclip' # File attachment management for ActiveRecord
gem 'aws-sdk', '< 2.0'
gem 'phony_rails'
gem 'twilio-ruby'

group :development do
  gem 'annotate'
  gem 'rubocop' # code syntax checker
  gem 'spring'
end

group :development, :test do
  # Stops execution and gets a debugger console
  gem 'byebug'
  gem 'rspec-rails'
  gem 'rspec-core'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'
end

group :production do
  gem 'thin'
end
