# frozen_string_literal: true
require 'aws-sdk'

module Adapters
  class S3
    include Singleton

    def self.file_to_buffer(s3_url)
      instance.file_to_buffer(s3_url)
    end

    def file_to_buffer(s3_url)
      object_output = bucket.object(s3_url).get
      object_output.body if object_output.present?
    end

    private

    def bucket
      @bucket ||= Aws::S3::Resource.new(credentials: Aws::Credentials.new(
        ENV['AWS_S3_KEY'], ENV['AWS_S3_SECRET']
      ), region: 'us-east-1').bucket(ENV['AWS_S3_BUCKET'])
    end
  end
end
