class Work < ActiveRecord::Base

  has_many :pictures, :as => :assetable, :dependent => :destroy, :order => :item_order
  has_many :category_items, :as => :item, :dependent => :destroy
  has_many :categories, :through => :category_items

  named_scope :active, :conditions => {:status => true}

  def image
      pictures.first
  end

  def self.newest limit=1
      active.find(:all, :limit => limit, :order => "created_at desc")
  end
end
