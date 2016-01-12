SalidoRailsChallenge::App.controllers :products do
  get :index do
    # WineApi.new.pull_and_insert('155bc41216c9b981b8a05cee921f4fb1')

    @wines = Product.all

    render 'products_index'
  end

  get :new do
  	render 'products_add'
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
end
