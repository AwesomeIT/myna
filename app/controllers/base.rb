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

      def ensure_record
        class_eval { before_enqueue :ensure_record }
      end

      def ensure_action
        class_eval { before_enqueue :ensure_action }
      end
    end

    private

    def action
      @action ||= params[:message].fetch(:action, nil)
    end

    # rubocop:disable Style/DoubleNegation
    def ensure_action
      throw(:abort) unless !!action &&
                           self.class.private_method_defined?(action)
    end
    # rubocop:enable Style/DoubleNegation

    def ensure_message
      throw(:abort) unless params.is_a?(Hash) &&
                           params.key?(:message) &&
                           params.fetch(:message).is_a?(Hash)
    end

    def ensure_record
      return if model_klass || model_klass.exists?(params[:message].fetch(:id))
      throw(:abort)
    end

    def model_klass
      @model_klass ||=
        "Kagu::Models::#{params[:message][:type].camelize}".safe_constantize
    end

    def record
      @record ||= model_klass.find(params[:message][:id])
    end
  end
end
