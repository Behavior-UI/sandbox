source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.3'

# MySQL2 Database Adapter Gem for accessing app.thanx.com production db
gem 'mysql2', '0.3.14'

# CSS Compressor
gem 'yui-compressor', '0.12.0'

# JavaScript Compressor
gem 'uglifier', '2.4.0'

# Less Asset Pipeline
gem 'therubyracer', '0.12.0', platform: :ruby
gem "less-rails"

gem 'unf'
# Amazon AWS - RDS, S3, SES, etc.
gem 'aws-sdk', '1.29.0'

# PaperClip Gem - https://github.com/thoughtbot/paperclip to access paperclipped assets on thanx-web
gem 'paperclip', '3.5.2'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Airbrake Error Dashboard - https://devcenter.heroku.com/articles/airbrake
gem 'airbrake', '3.1.14'

# Redcarpet - fast, safe and extensible Markdown to (X)HTML parser
gem 'redcarpet', '3.0.0'

gem "bower-rails", "~> 0.7.3"

# heroku specific gems
group :production do
  # Heroku web server
  gem 'unicorn', '4.7.0'
  # Asset Sync - Synchronizes assets between Rails and S3
  gem 'asset_sync', '1.0.0'
  # Add better Heroku support
  gem 'rails_12factor'
end

group :development do
  # Better error page
  gem 'better_errors'
  # Enable Better Error's advanced features
  gem 'binding_of_caller'
end

group :development, :test do
  # An IRB alternative and runtime developer console
  gem 'pry'
  gem 'pry-remote'
  gem 'pry-debugger'
  gem 'pry-rails'
end

ruby "2.1.1"
