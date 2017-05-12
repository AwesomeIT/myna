# frozen_string_literal: true
# Application controller from which all Karafka controllers should inherit
# You can rename it if it would conflict with your current code base
# (in case you're integrating
# Karafka with other frameworks)

# TODO: (not urgent leave it be fix after due date)
# This class seems to be doing parameter extraction s and a bunch of other
# things that don't seem to be its responsibility.
module Controllers
  class Base < Karafka::BaseController
    class << self
      def inherited(other)
        other.class_eval do
          before_enqueue :ensure_authorized
          before_enqueue :ensure_message
        end
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

    def authorization_key
      @authorization_key ||= params[:message]&.[](:authorization_key)
    end

    def ensure_authorized
      throw(:abort) unless authorization_key == ENV['KAFKA_SHARED_SECRET']
    end

    # rubocop:disable Style/DoubleNegation
    def ensure_action
      throw(:abort) unless !!action
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
        "Kagu::Models::#{type.try(:camelize)}".safe_constantize
    end

    def record
      @record ||= model_klass.find(params[:message][:id]) if type.present?
    end

    def type
      @type ||= params[:message].fetch(:type, nil)
    end
  end
end
