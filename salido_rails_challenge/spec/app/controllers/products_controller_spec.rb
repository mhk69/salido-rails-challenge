require 'spec_helper'

describe '/products' do

  describe '#index' do
    context 'when the page is rendered' do
      it 'returns a 200' do
        sample_json = {"Status":{"Messages":[],"ReturnCode":0},"Products":{"List":[{"Id":120039,"Name":"90+ Point Red Wine Trio","Url":"http:\/\/www.wine.com\/v6\/90-Point-Red-Wine-Trio\/gift\/120039\/Detail.aspx","Appellation":"","Labels":[{"Id":"120039m","Name":"thumbnail","Url":"http:\/\/cache.wine.com\/labels\/120039m.jpg"}],"Type":"WineSet","Varietal":"","Vineyard":"","Vintage":"","Community":{"Reviews":{"HighestScore":5,"List":[],"Url":"http:\/\/www.wine.com\/v6\/90-Point-Red-Wine-Trio\/gift\/120039\/Detail.aspx?pageType=reviews"},"Url":"http:\/\/www.wine.com\/v6\/90-Point-Red-Wine-Trio\/gift\/120039\/Detail.aspx"},"Description":"Test Description","GeoLocation":{"Latitude":-360,"Longitude":-360,"Url":""},"PriceMax":49.9900,"PriceMin":49.9900,"PriceRetail":49.9900,"ProductAttributes":[{"Id":0,"Name":"Wine Gift Sets","Url":"","ImageUrl":""},{"Id":0,"Name":"Best Sellers","Url":"","ImageUrl":""},{"Id":0,"Name":"Colleagues and Clients","Url":"","ImageUrl":""},{"Id":0,"Name":"For Him","Url":"","ImageUrl":""},{"Id":0,"Name":"Business Gifts","Url":"","ImageUrl":""},{"Id":0,"Name":"1-4 Bottles","Url":"","ImageUrl":""},{"Id":0,"Name":"Thank You","Url":"","ImageUrl":""},{"Id":0,"Name":"Has Large Label","Url":"","ImageUrl":""}],"Ratings":{"HighestScore":0,"List":[]},"Retail":"","Vintages":{"List":[]}}],"Offset":0,"Total":89950,"Url":""}}.deep_stringify_keys.to_json


        stub_request(:get, "http://services.wine.com/api/beta2/service.svc/JSON/catalog?apikey=155bc41216c9b981b8a05cee921f4fb1").
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'services.wine.com', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => sample_json, :headers => {})


        get '/products', {}

        expect(last_response.status).to eq(200)
      end
    end
  end

  describe '#new' do
    context 'when the page is rendered' do
      it 'returns a 200' do
        get '/products/new', {}

        expect(last_response.status).to eq(200)
      end

      it 'returns some valid content' do
        content = "Add a Wine"

        get '/products/new', {}

        expect(last_response.body).to include(content)
      end
    end
  end
end