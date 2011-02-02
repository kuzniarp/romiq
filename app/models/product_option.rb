class ProductOption < ActiveRecord::Base
  belongs_to :product
  belongs_to :option
  has_many :product_option_pictures
  has_many :pictures, :through => :product_option_pictures

  validates_uniqueness_of :option_id, :scope => :product_id
end
