# frozen_string_literal: true
# Application controller from which all Karafka controllers should inherit
# You can rename it if it would conflict with your current code base
# (in case you're integrating
# Karafka with other frameworks)
module Controllers
  class Base < Karafka::BaseController
    class << self
      def inherited(other)
        other.class_eval { before_enqueue :ensure_message }
      end

      def check_for_record
        class_eval { before_enqueue :check_for_record }
      end
    end

    private

    def check_for_record
      return if model_klass || model_klass.exists?(params[:message].fetch(:id))
      throw(:abort)
    end

    def model_klass
      @model_klass ||=
        "Kagu::Models::#{params[:message][:type].camelize}".safe_constantize
    end

    def ensure_message
      throw(:abort) unless params.is_a?(Hash) &&
                           params.key?(:message) &&
                           params.fetch(:message).is_a?(Hash)
    end
  end
end
