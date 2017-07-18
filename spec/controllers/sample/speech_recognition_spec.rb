require 'spec_helper'

describe Controllers::Sample::SpeechRecognition do
  context '#perform_async' do 
    let(:record) { double }

    before do
      expect(subject).to receive(:record).and_return(record).at_least(:once)
    end

    after { subject.perform_async }

    it 'calls the correct methods' do
      expect(record).to receive(:hypothesis=)
      expect(Services::Samples::SpeechRecognition)
        .to receive(:compute_hypothesis).with(record)

      expect(record).to receive(:save).and_return(true)
      expect(Kagu::Events::PostgresProducer)
        .to receive(:call).with(record).and_return(true)
    end
  end
end