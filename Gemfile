# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'bootsnap', require: false
gem 'devise'
gem 'devise-jwt'
gem 'graphql'
gem 'net-smtp'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.3'
gem 'recursive-open-struct'
gem 'rubocop', require: false
gem 'rubocop-rails'
gem 'rubocop-performance'
gem 'rubocop-rspec'
gem 'rubocop-rake'
gem 'tzinfo-data', '~> 1.2021', '>= 1.2021.5'

group :development, :test do
  gem 'awesome_print'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'ffi', '~> 1.9', '>= 1.9.10'
  gem 'pry'
  gem 'rspec-rails', '~> 5.1.2'
end

group :development do
end

group :test do
  gem 'shoulda-matchers'
end
