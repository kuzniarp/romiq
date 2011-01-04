class ProductCategory < Category
  has_many :products, :through => :category_items, :source => :item, :source_type => "Product"
  has_permalink :name, :unique => true, :to_param => :permalink
end
