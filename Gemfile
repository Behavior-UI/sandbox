source 'https://rubygems.org'

ruby '2.1.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.3'

# CSS Compressor
gem 'yui-compressor', '0.12.0'

# JavaScript Compressor
gem 'uglifier', '2.4.0'

# Less Asset Pipeline
gem 'therubyracer', '0.12.0', platform: :ruby
gem "less-rails"

gem 'unf'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Redcarpet - fast, safe and extensible Markdown to (X)HTML parser
gem 'redcarpet', '3.0.0'

# HTML, XML, SAX, and Reader parser
gem 'nokogiri', '1.6.1'

# heroku specific gems
group :production do
  # Heroku web server
  gem 'unicorn', '4.7.0'
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
  gem 'pry-rails'
end
