class WorkCategory < Category
      has_many :works, :through => :category_items, :source => :item, :source_type => "Work"
end