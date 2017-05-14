# frozen_string_literal: true
# require 'pocketsphinx-ruby'
require 'streamio-ffmpeg'

module Services
  module Samples
    class SpeechRecognition
      include Singleton

      def self.compute_hypothesis(sample)
        ''
        # instance.compute_hypothesis(sample)
      end

      # def compute_hypothesis(sample)
      #   with_buffer(sample.s3_key) do |file|
      #     recognizer.decode(file)
      #     recognizer.hypothesis
      #   end
      # end

      # private

      # def with_buffer(s3_key, &_block)
      #   # Dump the buffer to a temporary file
      #   tempfile = Tempfile.new('sphinxtemp')
      #   tempfile.write(
      #     Kagu::Adapters::S3.object_by_key(s3_key).get.body.read
      #   )
      #   tf_path = tempfile.path

      #   # ffmpeg it into PocketSphinx specs
      #   ff = FFMPEG::Movie.new(tf_path)
      #   ff.transcode("#{tf_path}.wav", %w(-acodec pcm_s16le -ar 16000 -ac 1))
      #   tempfile.unlink

      #   # Pass path to the block
      #   yield("#{tf_path}.wav").tap { File.delete("#{tf_path}.wav") }
      # end

      # def recognizer
      #   @recognizer ||= ::Pocketsphinx::Decoder.new(
      #     ::Pocketsphinx::Configuration.default
      #   )
      # end
    end
  end
end
