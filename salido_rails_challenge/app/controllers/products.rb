SalidoRailsChallenge::App.controllers :products do
  get :index do
    WineApi.new.pull_and_insert('155bc41216c9b981b8a05cee921f4fb1')

    @wines = Product.all


    render 'products_index'
  end

end
