class WorkCategory < Category
      has_many :works, :through => :category_items, :source => :item, :source_type => "Work"
      has_permalink :name, :to_param => :permalink
end