class ProductOption < ActiveRecord::Base
  belongs_to :product
  belongs_to :option
  has_many :product_option_pictures, :dependent => :destroy
  has_many :pictures, :through => :product_option_pictures

  validates_uniqueness_of :option_id, :scope => :product_id

  def long_name
    "#{self.option.feature.name} #{self.option.name}"
  end
end
