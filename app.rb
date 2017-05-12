# rubocop:disable Style/FrozenStringLiteralComment
ENV['RACK_ENV'] ||= 'development'
ENV['KARAFKA_ENV'] ||= ENV['RACK_ENV']

require './lib/includes'

Bundler.require(:default, ENV['KARAFKA_ENV'])

Dir['./lib/**/*.rb'].each(&method(:require))
Karafka::Loader.new.load(Karafka::App.root)

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
    topic :pg_sink do
      group :database
      controller Controllers::Events
      responder Responders::PostgresSink
    end

    topic :sample_speech_recognition do
      group :samples
      controller Controllers::Sample::SpeechRecognition
    end

    topic :es_manage do
      group :elasticsearch
      controller Controllers::Elasticsearch::Manage
    end
  end
end

App.boot!
