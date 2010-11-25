class Product < ActiveRecord::Base
  has_attached_file :image, :styles => {:thumb => "80>",
  		    	    	       	:medium => "300>"},
  :path => ":rails_root/public/assets/:attachment/:class/:id/:style/:filename", 
  :url => "/assets/:attachment/:class/:id/:style/:filename", :default_url => "/images/missing.png"

  has_permalink :name, :unique => true, :to_param => :permalink

  has_many :category_items, :as => :item
  has_many :categories, :through => :category_

  named_scope :active, :conditions => {:status => true}

  def self.newest limit=1
      active.find(:all, :limit => limit, :order => "created_at desc")
  end
end