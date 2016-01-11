class WineApi

  DEFAULT_SIZE = 5

  def pull_and_insert(api_key)
    url = build_url_and_params(api_key, DEFAULT_SIZE)
    pull_wine_db(url)
  end

  private
  def build_url_and_params(api_key, size)
    pull_url = WINE_DB_URL+"catalog?apikey=#{api_key}"

    params = { size: size, apikey: api_key }

    pull_url
  end

  def pull_wine_db(url)
    url = URI.parse(url)

    req = Net::HTTP::Get.new(url)

    res = ""
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }

    response = JSON.parse(res.body)
    insert_data(response)
  end

  def insert_data(data)
    data_list = data['Products']['List'].map { |product|
      Product.create(
        name: product['Name'],
        url: product['Url'],
        pricemin: product['PriceMin'],
        pricemax: product['PriceMax'],
        priceretail: product['PriceRetail'],
        winetype: product['Type']
      )
    }
  end
end