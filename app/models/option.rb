class Option < ActiveRecord::Base
  belongs_to :feature
  #has_many :product_options, :dependent => :destroy
  has_and_belongs_to_many :option_combinations
  has_many :pictures, :as => :assetable, :dependent => :destroy
end
