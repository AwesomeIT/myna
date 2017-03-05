describe Services::Samples::SpeechRecognition do 

  let(:file_url) { 'spec/fixtures/sound/hello.wav' }
  let(:sample) { FactoryGirl.create(:sample, s3_url: file_url) }
  let(:hello_sound) { File.open(file_url) }

  before do
    allow(Adapters::S3).to receive(:file_to_buffer)
      .with(any_args).and_return(hello_sound)
  end

  let(:parsed_speech) { described_class.parse_speech(sample.id) }

  it 'should attempt an inference' do
    expect(parsed_speech).to be_a(PocketSphinx::Decoder::Hypothesis)
  end
end