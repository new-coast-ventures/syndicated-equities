source 'http://rubygems.org'
ruby "2.4.4"

gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'dotenv', :require => 'dotenv/load'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# gem 'rails', '4.2.7.1'
gem 'rails', '5.2.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.0', group: :doc

gem 'devise'
gem 'rails_admin', '~> 1.0'
gem 'rails_admin_become_user'
gem 'bootstrap', '4.0.0.alpha5'
# gem 'paperclip', '>= 5.0'
gem 'aws-sdk'
gem "aws-sdk-s3", require: false
gem 'puma'
gem 'roo', '~> 2.7.0'
gem 'cancancan'
gem 'money-rails', '~>1'
gem 'recaptcha', require: 'recaptcha/rails'

gem 'active_storage_validations'

# Optional, to use :dimension validator
gem 'mini_magick'

# wysiwyg editor
gem 'tinymce-rails'


source 'http://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails', '~> 3.5'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem "letter_opener"
  # gem 'factory_girl_rails', '~> 4.0'
end

group :development, :test, :staging do
  gem 'ffaker'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :test do
  gem 'simplecov', require: false
end

gem 'rails_12factor', group: :production
