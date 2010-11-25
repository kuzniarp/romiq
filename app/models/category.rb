class Category < ActiveRecord::Base
      has_many :category_items, :dependent => :destroy
end