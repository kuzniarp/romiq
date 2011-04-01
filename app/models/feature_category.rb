class FeatureCategory < Category
  has_many :features, :through => :category_items, :source => :item, :source_type => "Feature"
  has_permalink :name, :unique => true, :to_param => :permalink

  alias_method :items, :features
end
