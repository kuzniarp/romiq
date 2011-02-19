class Option < ActiveRecord::Base
  belongs_to :feature
  #has_many :product_options, :dependent => :destroy
  has_and_belongs_to_many :option_combinations
  has_one :texture, :as => :assetable, :dependent => :destroy

  accepts_nested_attributes_for :texture, :allow_destroy => true

  named_scope :for_feature, lambda{|feature| {:conditions => { :feature_id => feature.id }} }

  def long_name
    "#{self.feature.name}: #{self.name}"
  end

  def set_texture
    texture || build_texture
  end
end
