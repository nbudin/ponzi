source 'http://rubygems.org'

ruby '1.9.3'

gem 'bundler'
gem 'rails', :git => 'https://github.com/makandra/rails.git', :branch => '3-0-lts'
gem 'mail', '~> 2.2.15'

gem 'json_pure'
gem 'mysql'

gem "devise", "~> 1.1.2"
#gem 'devise_cas_authenticatable', :path => '/Users/nbudin/code/devise_cas_authenticatable'
gem 'devise_cas_authenticatable', :git => "git://github.com/nbudin/devise_cas_authenticatable"
gem 'money', '~> 3.0.3'
gem 'eu_central_bank'

gem 'ae_users_migrator'
gem 'illyan_client'
gem 'rollbar'

gem 'unicorn', :group => :production
gem 'pg', :group => :production
gem 'newrelic_rpm'
gem 'rails_12factor'

gem 'pry', :groups => [:development, :test]

group :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
end
