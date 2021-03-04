source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.4'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'sprockets'
gem 'bcrypt', '~> 3.1.7'
gem 'faraday'
gem 'figaro'
gem 'chartkick', '~> 2.2.0'
gem 'devise', github: 'heartcombo/devise', branch: 'ca-omniauth-2'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'

gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'hirb'
  gem 'pry'
  gem 'travis'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'webmock'
  gem 'vcr'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry'
  gem 'rubocop-rails'
  gem 'travis'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
