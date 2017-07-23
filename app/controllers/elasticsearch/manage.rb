# frozen_string_literal: true
module Controllers
  module Elasticsearch
    class Manage < Controllers::Base
      ensure_action

      def perform_async
        service_args = case action
                       when 'destroy_record'
                         [action, message]
                       else
                         [action, record].compact
                       end

        Services::Elasticsearch::Manage.execute_action(
          *service_args
        ) if Services::Elasticsearch::Manage.method_defined?(action)
      end
    end
  end
end
