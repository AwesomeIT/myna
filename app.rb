# rubocop:disable Style/FrozenStringLiteralComment
ENV['RACK_ENV'] ||= 'development'
ENV['KARAFKA_ENV'] ||= ENV['RACK_ENV']

require './lib/includes'

Bundler.require(:default, ENV['KARAFKA_ENV'])

Dir['./lib/**/*.rb'].each(&method(:require))
Karafka::Loader.new.load(Karafka::App.root)

class Karafka::Logger
  # Map containing informations about log level for given environment
  ENV_MAP = {
    'production' => ::Logger::INFO,
    'test' => ::Logger::INFO,
    'development' => ::Logger::INFO,
    'debug' => ::Logger::INFO,
    default: ::Logger::INFO
  }.freeze
end

# App class
class App < Karafka::App
  setup do |config|
    config.kafka.hosts = ENV['KAFKA_HOSTS'].split(',')

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
