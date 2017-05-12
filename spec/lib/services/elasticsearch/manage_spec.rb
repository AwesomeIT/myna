describe Services::Elasticsearch::Manage do 
  let(:taggable_record) { FactoryGirl.create(:experiment) }

  context 'actions' do 
    context '#update_record' do
      it 'should invoke the correct es-model method' do
        expect(taggable_record.__elasticsearch__)
          .to receive(:index_document).and_return(true)

        described_class.instance.update_record(taggable_record)
      end
    end

    context '#destroy_record' do
      it 'should invoke the correct es-model method' do
        expect(taggable_record.__elasticsearch__)
          .to receive(:delete_document).and_return(true)

        described_class.instance.destroy_record(taggable_record)
      end
    end

    context '#update_all' do 
      it 'should invoke import on all taggables' do
        Tag.taggable_kinds.values.each do |tk|
          expect(tk).to receive(:import).and_return true
        end

        described_class.instance.update_all
      end
    end

    context '#force_reindex' do 
      it 'should force recreate index then import' do 
        Tag.taggable_kinds.values.each do |tk|
          expect(tk.__elasticsearch__).to receive(:create_index!)
            .with(force: true).and_return true
          expect(tk).to receive(:import).and_return true
        end

        described_class.instance.force_reindex
      end
    end
  end
end