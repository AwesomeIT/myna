# frozen_string_literal: true
module Responders
  class DatabaseEvents < Base
    # Topics in
    topic :object_created, required: false

    # Sample pipeline steps
    topic :sample_speech_recognition, required: false

    def respond(message)
      action = "#{message[:type]}_created"
      send(action, message) if self.class.private_method_defined?(action)
    end

    private

    # Processing pipeline for a new sample
    def sample_created(message)
      respond_to :sample_speech_recognition, message: message
    end
  end
end
