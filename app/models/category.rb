class Category < ActiveRecord::Base
  has_many :category_items, :dependent => :destroy
  acts_as_tree
  
  def to_param
    permalink      
  end

  def all_children
    items = [self]
    self.children.each do |child|
      items += child.all_children
    end
    items
  end
end
