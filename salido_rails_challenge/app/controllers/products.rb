SalidoRailsChallenge::App.controllers :products do
  get :index do
    # WineApi.new.pull_and_insert('155bc41216c9b981b8a05cee921f4fb1')

    @wines = Product.all

    render 'products_index'
  end

  get :new do
    render 'products_add'
  end

  get :edit do
    id = params['id']
    if Product.find(id).present?
      @wine = Product.find(id)
      render 'products_update'
    end
  end

  post :add, :csrf_protection => false do
    wine_name = params['wine_name']
    wine_url = params['wine_url']
    min_price = params['wine_minprice']
    max_price = params['wine_maxprice']
    retail_price = params['wine_retailprice']
    wine_type = params['wine_type']

    if wine_name.present? && wine_url.present? && min_price.present? && max_price.present? && retail_price && wine_type.present?
      Product.create(
        name: wine_name,
        url: wine_url,
        pricemin: min_price,
        pricemax: max_price,
        priceretail: retail_price,
        winetype: wine_type
      )
      redirect_to :products
    else
      render 'products_missing'
    end
  end

  post :update, :csrf_protection => false do
    wine_id = params['wine_id']
    wine_name = params['wine_name']
    wine_url = params['wine_url']
    min_price = params['wine_minprice']
    max_price = params['wine_maxprice']
    retail_price = params['wine_retailprice']
    wine_type = params['wine_type']

    wine = Product.find(wine_id.to_i)

    if not wine_name.present? || wine_url.present? || min_price.present? || max_price.present? || retail_price || wine_type.present?
      render 'products_missing'
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

      redirect_to :products
    end
  end
end
