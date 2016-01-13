require 'spec_helper'

describe WineApi do
  subject do
    @subject = WineApi.new
  end

  describe '#pull_and_insert' do
    context 'when pull is called with a valid apikey' do
      before do
        allow(subject).to receive(:pull_wine_db)
        allow(subject).to receive(:insert_data)
      end
      it 'calls build_url_and_params with the proper params' do
        api_key = WINE_DB_KEY

        expect(subject).to receive(:build_url_and_params).with(api_key, 5).once

        subject.pull_and_insert(api_key)
      end

      # Ideally a test here to be able to check return is a list and one for proper data - not sure how to set this one up properly
    end
  end
end