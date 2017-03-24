describe Services::Samples::SpeechRecognition do 
  let(:file_url) { 'spec/fixtures/sound/hello.wav' }
  let(:hello_sound) { File.open(file_url) }
  let(:sample) { FactoryGirl.create(:sample, s3_url: file_url) }

  context '#compute_hypothesis' do
    before do
      allow(Adapters::S3).to receive(:file_to_buffer)
        .with(any_args).and_return(hello_sound)
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