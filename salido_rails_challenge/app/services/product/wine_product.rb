class WineProduct
	attr_reader :name, :url, :pricemin, :pricemax, :priceretail, :wine_type

	def initialize(name, url, pricemin, pricemax, priceretail, wine_type)
		@name = name
		@url = url
		@pricemin = pricemin
		@pricemax = pricemax
		@priceretail = priceretail
		@wine_type = wine_type
	end
end