class OptionCombination < ActiveRecord::Base
  belongs_to :product
  has_and_belongs_to_many :options
  has_many :option_combination_pictures, :dependent => :destroy
  has_many :pictures, :through => :option_combination_pictures


  def long_name
    "#{self.options.map{|o| o.feature.name.to_s + ': ' + o.name.to_s}.join(', ')}"
  end
end
