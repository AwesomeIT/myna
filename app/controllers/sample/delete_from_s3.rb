# frozen_string_literal: true
module Controllers
  module Sample
    class DeleteFromS3 < Base
      def perform_async
        object = Kagu::Adapters::S3.object_by_key(message[:s3_key])
        return unless object.present?
        object.delete if object.present? && object.is_a?(Aws::S3::Object)
      end
    end
  end
end
