ruby '1.9.3'

source 'https://rubygems.org'

gem 'aws-sdk'
gem 'rails', '3.2.9'
# gem 'berkshelf' http://www.getchef.com/downloads/chef-dk/mac/
# 
gem 'bootstrap-sass'
gem 'font-awesome-less'
gem "font-awesome-rails"
gem 'omniauth'
gem 'omniauth-facebook'
gem 'balanced', "1.1"
gem 'faraday','~> 0.8.6'

gem "koala", "~> 1.7.0rc1"
gem "bitly"

gem 'resque'
gem 'resque-scheduler'
gem 'libv8', '3.11.8.17'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
group :development do
  gem 'sqlite3'
end

group :production do
 # specifically rmagick 2.12.2 works with ruby 1.9.3
 # and supports ImageMagick v6.8
  gem 'rmagick', '2.13.2'
  gem 'pg'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem "therubyracer"
  gem "less-rails"
  gem 'twitter-bootstrap-rails'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
  gem "therubyracer"
  gem "less-rails"
  gem 'twitter-bootstrap-rails'
end

group :test do
  gem 'rspec-rails'
end


gem 'jquery-rails'
gem 'stripe'


# for making physical products to sell....
gem 'rqrcode-rails3'

gem 'mini_magick'

#, :git => 'git://github.com:samvincent/rqrcode-rails3.git'


gem 'activeadmin'

#devise for making user login...
gem 'devise'


gem 'workflow'
#gem "nifty-generators", :group => :development


# gem 'spree_stripe', :git=>"git://github.com/adiastyle/spree-stripe.git"

#gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'