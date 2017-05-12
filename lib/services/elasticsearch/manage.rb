# frozen_string_literal: true

module Services
  module Elasticsearch
    class Manage
      include Singleton

      def self.execute_action(action, *args)
        instance.send(action, *args)
      end

      def update_record(record)
        record.__elasticsearch__.index_document
      end

      def destroy_record(record)
        record.__elasticsearch__.delete_document
      end

      def update_all
        Tag.taggable_kinds.values.each(&:import)
      end

      def force_reindex
        Tag.taggable_kinds.values.each do |t|
          t.__elasticsearch__.create_index!(force: true)
          t.import
        end
      end
    end
  end
end
