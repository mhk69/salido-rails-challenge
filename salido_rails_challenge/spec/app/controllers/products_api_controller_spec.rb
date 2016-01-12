require 'spec_helper'

describe '/products_api' do

  describe '#list' do
    context 'when list is called when there are products' do
      it 'returns a 200' do
        get '/products_api/list', {}

        expect(last_response.status).to eq(200)
      end

      # it 'returns a product json' do

      # end
    end

    context 'when list is called when there are no products' do
      it 'returns a 200' do
        get '/products_api/list', {}

        expect(last_response.status).to eq(200)
      end

      # it 'returns a product json' do

      # end
    end
  end

  describe '#details' do
    context 'when details is called with a valid wine_id' do
      it 'returns a 200' do
        get '/products_api/details?wine_id=1', {}

        expect(last_response.status).to eq(200)
      end

      # it 'returns details about that wine' do

      # end
    end

    # context 'when details is caleld with an invalid wine_id' do
    #   it 'returns a 200' do

    #   end

    #   it 'returns an error json' do

    #   end
    # end
  end

end