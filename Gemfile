# encoding: utf-8
source 'https://rubygems.org'

ruby '2.4.1'

gem 'activerecord'
gem 'activesupport'

# Kafka MVC
gem 'karafka'
gem 'waterdrop'

# ffmpeg for audio gymnastics
gem 'streamio-ffmpeg'

group :development do
  gem 'database_cleaner', '1.5.3'
  gem 'factory_girl'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop'
  gem 'pry', require: true
  # TODO: rebuild docker container with libreadline-dev
  # gem 'pry-byebug', require: true
  gem 'rubocop', '~> 0.47.1', require: false
end

# Test coverage
group :test do
  gem "simplecov"
  gem "codeclimate-test-reporter", "~> 1.0.0"
end

# TalkBirdy standard library
kagu_cfg = if ENV.key?('KAGU_PATH')
  { path: ENV['KAGU_PATH'] }
else
  { git: 'https://github.com/awesomeit/kagu' }
end

gem 'kagu', kagu_cfg.merge(require: false)

# Speech recognition
gem 'pocketsphinx-ruby', git: 'https://github.com/mach-kernel/pocketsphinx-ruby.git', branch: 'sphinxbase-debug-log-level-api-change'

# AWS
gem 'aws-sdk', '2.7.15'

# ???
gem 'pry'

gem 'foreman'
