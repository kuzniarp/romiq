class Category < ActiveRecord::Base
      has_many :category_items, :dependent => :destroy
      acts_as_tree

#      def children
#      	  Category.find(:all, :conditions => {:parent_id => self.id})
#      end  
end