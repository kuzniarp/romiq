class ProductOptionPicture  < ActiveRecord::Base
  belongs_to :product_option
  belongs_to :picture
end
