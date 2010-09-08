source 'http://rubygems.org'

gem 'rails',  '3.0.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'haml',   '3.0.18'
gem 'mysql2'
gem 'compass-susy-plugin', '0.8.0' # Responsive web design with grids the quick and reliable way
                                   # To susy-fy your project, run:
                                   # compass init rails -r susy -u susy --sass-dir=app/stylesheets --css-dir=public/stylesheets/compiled
                                   # from the command-line.

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

group :development do
  gem 'haml-rails',         '0.2' # Haml-rails provides Haml generators for Rails 3.
  gem 'rails3-generators',  '0.13.0' # Rails 3 compatible generators for DataMapper, Factory-girl, etc.
  gem 'ruby-graphviz',      '0.9.17' # For running 'bundle viz'
end

group :test, :development do
  # gem 'capybara', '0.3.9'
  gem 'factory_girl_rails', '1.0'
  gem 'rspec-rails',        '>= 2.0.0.beta.20'
  # gem 'webrat', '0.7.1'
end