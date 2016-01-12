require 'spec_helper'

describe '/products_api' do

  describe '#list' do
    context 'when list is called when there are products' do
      it 'returns a 200' do
        get '/products_api/list', {}

        expect(last_response.status).to eq(200)
      end

      it 'returns a product json with the proper details' do
        FactoryGirl.create :product

        get '/products_api/list', {}

        json = JSON.parse(last_response.body)
        expect(json[0]['name']).to eq('factory_name')
        expect(json[0]['winedb_url']).to eq('factory_url')
        expect(json[0]['prices']['min_price']).to eq(1.99)
        expect(json[0]['prices']['max_price']).to eq(3.99)
        expect(json[0]['prices']['retail_price']).to eq(2.99)
        expect(json[0]['type']).to eq('Red Wine')
      end
    end

    context 'when list is called when there are no products' do
      it 'returns a 200' do
        get '/products_api/list', {}

        expect(last_response.status).to eq(200)
      end

      it 'returns an empty list json' do
        get '/products_api/list', {}

        json = JSON.parse(last_response.body)

        expect(json).to eq([])
      end
    end
  end

  describe '#details' do
    context 'when details is called with a valid wine_id' do
      before do
        FactoryGirl.create :product
      end
      it 'returns a 200' do
        get '/products_api/details?wine_id=1', {}

        expect(last_response.status).to eq(200)
      end

      it 'returns the proper details about that wine' do
        get '/products_api/details?wine_id=1', {}

        json = JSON.parse(last_response.body)

        expect(json['details']['name']).to eq('factory_name')
        expect(json['details']['winedb_url']).to eq('factory_url')
        expect(json['details']['prices']['min_price']).to eq(1.99)
        expect(json['details']['prices']['max_price']).to eq(3.99)
        expect(json['details']['prices']['retail_price']).to eq(2.99)
        expect(json['details']['type']).to eq('Red Wine')
      end
    end

    context 'when details is called with an invalid wine_id' do
      it 'returns a 200' do
        get '/products_api/details?wine_id=1', {}

        expect(last_response.status).to eq(200)
      end

      it 'returns an empty json' do
        get '/products_api/details?wine_id=1', {}

        json = JSON.parse(last_response.body)

        expect(json['details']).to eq({})
      end
    end
  end

  describe '#update' do
    context 'when update is called with a valid wine_id' do
      before do
        FactoryGirl.create :product

        @body = "{\"wine_id\": 1, \"wine_name\": \"new_name\"}"
      end
      it 'returns a 200' do
        post '/products_api/update', @body

        expect(last_response.status).to eq(200)
      end

      it 'returns the updated details about that wine' do
        post '/products_api/update', @body

        json = JSON.parse(last_response.body)

        expect(json['name']).to eq('new_name')
        expect(json['winedb_url']).to eq('factory_url')
        expect(json['prices']['min_price']).to eq(1.99)
        expect(json['prices']['max_price']).to eq(3.99)
        expect(json['prices']['retail_price']).to eq(2.99)
        expect(json['type']).to eq('Red Wine')
      end
    end

    context 'when update is called with an invalid wine_id' do
      before do
        @body = "{\"wine_id\": 1, \"wine_name\": \"new_name\"}"
      end

      it 'returns a 200' do
        post '/products_api/update', @body

        expect(last_response.status).to eq(200)
      end

      it 'returns an empty json' do
        post '/products_api/update', @body

        json = JSON.parse(last_response.body)

        expect(json['details']).to eq({})
      end
    end
  end

end