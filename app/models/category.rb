class Category < ActiveRecord::Base
  has_many :category_items, :dependent => :destroy
  acts_as_tree
  
  def to_param
    permalink      
  end
end
