describe Adapters::S3 do
  context '.file_to_buffer' do
    let(:s3_url) { 'foo/bar/baz.avi' }

    after { Adapters::S3.file_to_buffer(s3_url) }

    it 'should invoke the correct methods' do 
      expect_any_instance_of(Aws::S3::Resource)
        .to receive(:bucket)
        .and_return(
          Aws::S3::Bucket.new(name: 'foo', region: 'test')
        )

      expect_any_instance_of(Aws::S3::Bucket)
        .to receive(:object)
        .with(s3_url)
        .and_return(
          Aws::S3::Object.new(
            bucket_name: 'foo', key: s3_url, region: 'us-east-1'
          )
        )

      expect_any_instance_of(Aws::S3::Object)
        .to receive(:get)
    end
  end
end