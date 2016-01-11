# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  url         :string
#  pricemin    :float
#  pricemax    :float
#  priceretail :float
#  type        :string
#  created_at  :datetime
#  updated_at  :datetime
#

class Product < ActiveRecord::Base
	validates :name, :url, :uniqueness => true
end
