SalidoRailsChallenge::App.controllers :products_api do
  get :list do
    wines = Product.all

    wines_json = wines.map{ |wine|
      wine_json = {
        name: wine.name,
        winedb_url: wine.url,
        prices: {
          min_price: wine.pricemin,
          max_price: wine.pricemax,
          retail_price: wine.priceretail
        },
        type: wine.winetype
        }.deep_stringify_keys
      }.to_json
  end

  get :details do
    id = params['wine_id']
    wine = Product.find(id.to_i)

    wine_json = {
      name: wine.name,
      winedb_url: wine.url,
      prices: {
        min_price: wine.pricemin,
        max_price: wine.pricemax,
        retail_price: wine.priceretail
      },
      type: wine.winetype
    }.deep_stringify_keys.to_json
  end

  post :update, :csrf_protection => false do
    json      = JSON.parse(request.body.read)

    wine_id = params['wine_id']
    wine_name = params['wine_name']
    wine_url = params['wine_url']
    min_price = params['wine_minprice']
    max_price = params['wine_maxprice']
    retail_price = params['wine_retailprice']
    wine_type = params['wine_type']

    wine = Product.find(wine_id.to_i)

    if not wine_name.present? || wine_url.present? || min_price.present? || max_price.present? || retail_price || wine_type.present?
      {error: "missing any update data"}.deep_stringify_keys.to_json
    else
      if wine_name.present?
        wine.update_attributes!(name: wine_name.to_s)
      end
      if wine_url.present?
        wine.update_attributes!(url: wine_url.to_s)
      end
      if min_price.present?
        wine.update_attributes!(pricemin: min_price.to_f)
      end
      if max_price.present?
        wine.update_attributes!(pricemax: max_price.to_f)
      end
      if retail_price.present?
        wine.update_attributes!(priceretail: retail_price.to_f)
      end
      if wine_type.present?
        wine.update_attributes!(winetype: wine_type.to_s)
      end

    wine_json = {
      name: wine.name,
      winedb_url: wine.url,
      prices: {
        min_price: wine.pricemin,
        max_price: wine.pricemax,
        retail_price: wine.priceretail
      },
      type: wine.winetype
    }.deep_stringify_keys.to_json
    end
  end
end
