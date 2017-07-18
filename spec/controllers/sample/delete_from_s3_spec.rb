require 'spec_helper'

describe Controllers::Sample::DeleteFromS3 do
  context '#perform_async' do 
    let(:message) { { s3_key: 'foo' } }

    before do 
      expect(subject).to receive(:message).and_return(message).at_least(:once)
    end

    after { subject.perform_async }

    it 'should call the correct methods' do
      expect(Kagu::Adapters::S3).to receive(:object_by_key)
        .with(message[:s3_key])
    end
  end
end