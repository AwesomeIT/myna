# rubocop:disable Style/FrozenStringLiteralComment

ENV['RACK_ENV'] ||= 'development'
ENV['KARAFKA_ENV'] ||= ENV['RACK_ENV']

require 'active_support'
require 'active_support/core_ext'
require 'singleton'
require 'sentry-raven'

Bundler.require(:default, ENV['KARAFKA_ENV'])

Dir['./app/**/*.rb'].sort.each(&method(:require))
Dir['./lib/**/*.rb'].sort.each(&method(:require))
require './config/database_bootstrap'

Karafka::Loader.new.load(Karafka::App.root)

# Only spit errors in production
Raven.configure do |config|
  config.environments = %w(production)
end

# App class
class App < Karafka::App
  setup do |config|
    config.kafka.hosts = ENV.fetch('KAFKA_HOSTS', '').split(',')

    config.name = 'talkbirdy-myna'
    config.redis = { url: case ENV['KARAFKA_ENV']
                          when /production/
                            ENV['REDIS_URL']
                          else
                            'redis://localhost:6379'
                          end }

    config.inline_mode = false
  end

  routes.draw do
    topic :sample_speech_recognition do
      controller Controllers::Sample::SpeechRecognition
    end

    topic :sample_delete_from_s3 do
      controller Controllers::Sample::DeleteFromS3
    end

    topic :es_manage do
      controller Controllers::Elasticsearch::Manage
    end
  end
end

App.boot!

# rubocop:enable Style/FrozenStringLiteralComment
