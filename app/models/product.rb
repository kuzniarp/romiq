class Product < ActiveRecord::Base
#  has_attached_file :image, :styles => {:thumb => "80>",
#  		    	    	       	:medium => "300>"},
#  :path => ":rails_root/public/assets/:attachment/:class/:id/:style/:filename", 
#  :url => "/assets/:attachment/:class/:id/:style/:filename", :default_url => "/images/missing.png"

  has_permalink :name, :unique => true, :to_param => :permalink

  has_many :pictures, :as => :assetable, :dependent => :destroy, :order => :item_order
  has_many :category_items, :as => :item, :dependent => :destroy
  has_many :categories, :through => :category_items

  has_many :option_combinations, :dependent => :destroy

  named_scope :active, :conditions => {:status => true}

  named_scope :for_categories, lambda {|categories| {:conditions => ["categories.id in (?)", categories.map(&:id)], :include => :categories}}

#  cattr_reader :per_page
#  @@per_page = 10

  ALLOWED_VIEWS = {'short_view' => 50, 'medium_view' => 30, 'long_view' => 15}

  ALLOWED_ORDERS = {'date' => 'products.created_at desc', 'name' => 'products.name'}

  def self.newest limit=1
    active.find(:all, :limit => limit, :order => "created_at desc")
  end
  
  def image
    pictures.first
  end
end
