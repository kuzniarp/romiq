class Work < ActiveRecord::Base

  has_many :pictures, :as => :assetable
  has_many :category_items, :as => :item
  has_many :categories, :through => :category_items

  def image
      pictures.first
  end
end
