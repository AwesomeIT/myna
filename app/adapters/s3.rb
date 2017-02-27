require 'aws-sdk'

module Adapters
  class S3
    include Singleton

    def self.file_to_buffer(s3_url)
      self.instance.get.body
    end

    def file_to_buffer(s3_url)
      bucket.object(s3_url).get.body
    end

    private

    def bucket
      @bucket ||= Aws::S3::Resource.new(credentials: Aws::Credentials.new(
        ENV['AWS_S3_KEY'], ENV['AWS_S3_SECRET']
      )).bucket(ENV['AWS_S3_BUCKET'])
    end
  end
end