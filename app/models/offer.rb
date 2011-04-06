class Offer < ActiveRecord::Base
  has_many :offer_items
  has_many :products, :through => :offer_items, :source => :item, :source_type => "Product"
  has_many :categories, :through => :offer_items, :source => :item, :source_type => "Category"

  named_scope :active, :conditions => {:status => true}
  
  def all_products
    all_products = products.active
    all_products += categories.map{|c| c.products.active}.flatten
    all_products
  end
end
