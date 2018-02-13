source 'https://rubygems.org'

ruby '>= 2.1.0'

# Use Unicorn as the app server
gem 'unicorn'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jQuery as the JavaScript library
gem 'jquery-rails', '~> 4.0'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development


gem 'enumerize'
gem 'pg'
gem 'geokit-rails'


group :development, :test do
  # Call 'debugger' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'pry-rails'
  #gem 'pry-nav'

  # Guard::LiveReload automatically reload your browser when 'view' files are modified.
  # Not working
  # gem 'guard-livereload', require: false

  gem 'awesome_print'
  gem 'better_errors'
  gem 'binding_of_caller'  # Advanced mode for better_errors
  gem 'bullet'
  gem 'quiet_assets'

  # Use debugger
  # gem 'debugger'

  # Process manager for applications with multiple components
  gem 'foreman'

  # Test
  gem 'capybara'
  gem 'launchy'
  gem 'guard-rspec'
  gem 'rspec-rails'
  gem 'timecop'

  gem 'traceroute'
  gem 'selenium-webdriver'
end

group :production do
  # Serve assets
  gem 'rails_12factor'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end
