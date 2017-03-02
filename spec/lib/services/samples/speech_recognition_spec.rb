require 'pry'
describe Services::Samples::SpeechRecognition do 
  let(:hello_sound) { File.open('spec/fixtures/sound/hello.wav')}

  before do
    allow(Adapters::S3).to receive(:file_to_buffer)
      .with(any_args).and_return(hello_sound)

  end

  it 'should attempt an inference' do 
        described_class.parse_speech(3)

  end
end