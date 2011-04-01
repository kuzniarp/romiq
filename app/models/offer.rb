class Offer < ActiveRecord::Base
  has_many :offer_items
  has_many :products, :through => :offer_items, :source => :item, :source_type => "Product"
  has_many :categories, :through => :offer_items, :source => :item, :source_type => "Category"
end
