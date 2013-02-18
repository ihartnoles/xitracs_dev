source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

platforms :ruby do
	gem 'mysql2'
	gem 'therubyracer'
	#gem 'therubyracer', :require => false if RUBY_PLATFORM =~ /darwin/i
end

platforms :jruby do
	gem 'activerecord-jdbcmysql-adapter'
	gem 'jdbc-mysql'
	gem 'jruby-openssl'
	gem 'therubyrhino'
end


gem 'jquery-rails'
gem 'awesome_print'   # Pretty Printer

gem 'net-ldap'        # LDAP Authentication (to AD)
gem 'google_visualr'  # Google Charts
gem 'railroady'       # UML Models
gem 'kaminari'        # Pagination
gem 'rubycas-client'  # CAS Authentication 
gem 'simple_enum'     # Enumerations
gem 'foreigner'       # Foreign Keys Support
gem 'carrierwave'	  # Uploads
gem 'wicked'		  # Wizard

# Gems used only for assets and not required
# in production environments by default.

group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
end
