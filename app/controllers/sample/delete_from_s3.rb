# frozen_string_literal: true
module Controllers
  module Sample
    class DeleteFromS3 < Base
      ensure_message

      def perform_async
        object = Kagu::Adapters::S3.object_by_key(message[:s3_key])
        return unless object.present?
        object.delete
      end
    end
  end
end
