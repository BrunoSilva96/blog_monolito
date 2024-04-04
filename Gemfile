source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'devise'

gem 'importmap-rails'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.8', '>= 7.0.8.1'
gem 'sprockets-rails'
gem 'turbo-rails'

gem 'bootsnap', require: false
gem 'bootstrap'
gem 'jbuilder'
gem 'jquery-rails'
gem 'sassc-rails'
gem 'stimulus-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'rspec-rails', '~>4.0.1'
  gem 'rubocop', require: false
  gem 'shoulda-matchers', '~> 6.1'
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
end
