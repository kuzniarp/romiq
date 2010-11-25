class CategoryItem < ActiveRecord::Base
      belongs_to :category
      belongs_to :item, :polymorphic => true
end
