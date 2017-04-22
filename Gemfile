# encoding: utf-8
source 'https://rubygems.org'

gem 'activerecord'
gem 'activesupport'

# Kafka MVC
gem 'karafka'

# ffmpeg for audio gymnastics
gem 'streamio-ffmpeg'

group :development do
  gem 'database_cleaner', '1.5.3'
  gem 'factory_girl'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop'
  gem 'pry', require: true
  gem 'pry-byebug', require: true
  gem 'rubocop', '~> 0.47.1', require: false
end

# Test coverage
group :test do
  gem "simplecov"
  gem "codeclimate-test-reporter", "~> 1.0.0"
end

# Database Models
gem 'kagu', git: 'git://github.com/birdfeed/kagu.git'

# Speech recognition
gem 'pocketsphinx-ruby', '0.3.0'

# AWS
gem 'aws-sdk', '2.7.15'
