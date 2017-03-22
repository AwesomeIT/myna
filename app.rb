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
    config.kafka.hosts = %w(127.0.0.1:9092)
    config.name = 'talkbirdy-myna'
    config.redis = {
      url: 'redis://localhost:6379'
    }
    config.inline_mode = false
  end

  routes.draw do
    topic :object_created do
      group :events
      controller Controllers::Events
      responder Responders::Events
    end

    topic :sample_speech_recognition do
      group :samples
      controller Controllers::Sample::SpeechRecognition
      # responder Responders::Events
    end
  end
end

App.boot!
# rubocop:enable Style/FrozenStringLiteralComment
