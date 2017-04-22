# frozen_string_literal: true
module Controllers
  module Elasticsearch
    class Manage < Base
      ensure_action

      def perform_async
        Services::Elasticsearch::Manage
          .execute_action(*[action, record].compact)
      end
    end
  end
end
