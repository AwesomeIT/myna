require 'spec_helper' 

describe Controllers::Elasticsearch::Manage do 
  context '#perform_async' do 
    let(:message) { double }
    let(:record) { double }

    before do
      expect(subject).to receive(:action).and_return(action).at_least(:once)

      expect(subject).to receive(:message).and_return(message).at_most(:once)
      expect(subject).to receive(:record).and_return(record).at_most(:once)

      expect(Services::Elasticsearch::Manage)
        .to receive(:method_defined?).with(action).and_return(true)
    end

    after { subject.perform_async }

    context 'destroy_record' do 
      let(:action) { 'destroy_record' }

      it 'should call the Elasticsearch service correctly' do 
        expect(Services::Elasticsearch::Manage)
          .to receive(:execute_action).with(action, message).and_return(true)
      end
    end

    context 'update_record' do 
      let(:action) { 'update_record' }

      it 'should call the Elasticsearch service correctly' do 
        expect(Services::Elasticsearch::Manage)
          .to receive(:execute_action).with(action, record).and_return(true)
      end
    end
  end
end