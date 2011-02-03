class Option < ActiveRecord::Base
  belongs_to :feature
  has_many :product_options, :dependent => :destroy
  has_many :pictures, :as => :assetable, :dependent => :destroy
end
