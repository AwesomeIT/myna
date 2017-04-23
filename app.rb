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
    config.kafka.hosts = case ENV['KARAFKA_ENV']
                         when /production/
                           ENV['CLOUDKARAFKA_HOSTS'].split(',')
                         else
                           %w(127.0.0.1:9092)
                         end

    config.topic_mapper = TopicMapper.new

    config.name = 'talkbirdy-myna'
    config.redis = { url: case ENV['KARAFKA_ENV']
                          when /production/
                            ENV['REDIS_URL']
                          else
                            'redis://localhost:6379'
                          end }

    config.inline_mode = false

    if ENV['KARAFKA_ENV'] == 'production'
      config.kafka.ssl.ca_cert = ENV['CLOUDKARAFKA_CA']
      config.kafka.ssl.client_cert = ENV['CLOUDKARAFKA_CERT']
      config.kafka.ssl.client_cert_key = ENV['CLOUDKARAFKA_PKEY']
    end
  end

  routes.draw do
    topic :object_created do
      group :database_events
      controller Controllers::Events
      responder Responders::DatabaseEvents
    end

    topic :sample_speech_recognition do
      group :samples
      controller Controllers::Sample::SpeechRecognition
      # responder Responders::Events
    end

    topic :es_manage do
      group :elasticsearch
      controller Controllers::Elasticsearch::Manage
    end
  end
end

App.boot!
