class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.string :url
      t.float :pricemin
      t.float :pricemax
      t.float :priceretail
      t.string :winetype
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
