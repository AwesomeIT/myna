module Services
  module Samples
    class SpeechRecognition
      include Singleton

      def self.parse_speech(sample_id)
      end

      def parse_speech(sample_id)
        sample = Sample.find(sample_id)


      end

      private

      def fetch_file
        
      end

      def recognizer
        @recognizer ||= Pocketsphinx::AudioFileSpeechRecognizer.new
      end
    end    
  end
end