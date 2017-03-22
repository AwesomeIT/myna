# frozen_string_literal: true
module Controllers
  module Sample
    class SpeechRecognition < Base
      check_for_record

      def perform_async
        sample = Sample.find(params[:message][:id])
        sample.hypothesis =
          Services::Samples::SpeechRecognition.compute_hypothesis(sample).to_s
        sample.save
      end
    end
  end
end
