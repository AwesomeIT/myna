# frozen_string_literal: true
require 'pocketsphinx-ruby'

module Services
  module Samples
    class SpeechRecognition
      include Singleton

      def self.parse_speech(sample_id)
        instance.parse_speech(sample_id)
      end

      def parse_speech(sample_id)
        recognizer.decode(fetch_buffer(::Sample.find(sample_id).s3_url))
        recognizer.hypothesis
      end

      private

      def fetch_buffer(s3_url)
        Adapters::S3.file_to_buffer(s3_url)
      end

      def recognizer
        @recognizer ||= ::Pocketsphinx::Decoder.new(
          ::Pocketsphinx::Configuration.default
        )
      end
    end
  end
end
