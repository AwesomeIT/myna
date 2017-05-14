describe Services::Samples::SpeechRecognition do 
  let(:file_url) { 'spec/fixtures/sound/hello.wav' }
  let(:hello_sound) { File.open(file_url) }
  let(:sample) { FactoryGirl.create(:sample, s3_key: file_url) }

  let(:s3_object) { double }

  xcontext '#compute_hypothesis' do
    before do
      allow(Kagu::Adapters::S3).to receive(:object_by_key)
        .with(file_url).and_return(s3_object)

      expect(s3_object)
        .to receive_message_chain(:get, :body)
        .and_return(hello_sound)
    end

    let(:parsed_speech) { described_class.compute_hypothesis(sample) }

    it 'should invoke ffmpeg for conversion' do 
      expect_any_instance_of(FFMPEG::Movie)
        .to receive(:transcode).and_call_original
      parsed_speech
    end

    it 'should attempt an inference' do
      expect(parsed_speech).to be_a(Pocketsphinx::Decoder::Hypothesis)
    end    
  end
end