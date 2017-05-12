# frozen_string_literal: true

module Services
  module Elasticsearch
    class Manage
      include Singleton

      def self.execute_action(action, *args)
        instance.send(action, *args)
      end

      def es_client
        @es_client ||= ::Elasticsearch::Client.new(log: true)
      end

      def destroy_record(record_data)
        klass = record_data[:type].constantize

        es_client.delete(
          index: klass.__elasticsearch__.index_name,
          type: klass.__elasticsearch__.document_type,
          id: record_data[:id]
        )
      end

      def force_reindex
        Tag.taggable_kinds.values.each do |t|
          t.__elasticsearch__.create_index!(force: true)
          t.import
        end
      end

      def update_all
        Tag.taggable_kinds.values.each(&:import)
      end

      def update_record(record)
        record.__elasticsearch__.index_document
      end
    end
  end
end
