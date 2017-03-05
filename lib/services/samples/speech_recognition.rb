# frozen_string_literal: true
require 'pocketsphinx-ruby'

module Services
  module Samples
    class SpeechRecognition
      include Singleton

      def self.compute_hypothesis(sample)
        instance.compute_hypothesis(sample)
      end

      def compute_hypothesis(sample)
        recognizer.decode(fetch_buffer(sample.s3_url))
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
