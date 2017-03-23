# frozen_string_literal: true
require 'pocketsphinx-ruby'
require 'streamio-ffmeg'

module Services
  module Samples
    class SpeechRecognition
      include Singleton

      def self.compute_hypothesis(sample)
        instance.compute_hypothesis(sample)
      end

      def compute_hypothesis(sample)
        prepare_buffer(sample.s3_url)
        recognizer.decode(wav_tmpfile)
        recognizer.hypothesis.tap do
          File.delete(wav_tmpfile)
          @tf_path = nil
        end
      end

      private

      attr_reader :tf_path

      def prepare_buffer(s3_url)
        # Dump the buffer to a temporary file
        tempfile = Tempfile.new('sphinxtemp')
        tempfile.write(Adapters::S3.file_to_buffer(s3_url))
        @tf_path = tempfile.path

        # ffmpeg it into PocketSphinx specs
        ff = FFMPEG::Movie.new(@tf_path)
        ff.transcode("#{tf_path}-wv", %w(-ar 1600 -ac 1)
        tempfile.unlink
      end

      def recognizer
        @recognizer ||= ::Pocketsphinx::Decoder.new(
          ::Pocketsphinx::Configuration.default
        )
      end

      def wav_tmpfile
        "#{@tf_path}-wv"
      end
    end
  end
end
