class Page < ActiveRecord::Base

  has_permalink :name
  has_many :pictures, :as => :assetable
  
  acts_as_tree :order => "item_order"

  named_scope :active, :conditions => {:status => true}

  before_save :update_header

  def to_param
    permalink
  end

  def self.menu_pages
    pages = active.all(:conditions => {:parent_id => nil})
    pages << ProductPage.new(:name => "Produkty", :permalink => "produkty", :item_order => 1.1)
    pages << WorkPage.new(:name => "Galeria", :permalink => "galeria", :item_order => 1.2)
    pages.sort_by(&:item_order)
  end
  
  def self.top_level_pages
    all(:conditions => {:parent_id => nil})
  end

  def self.home_page
    HomePage.first || HomePage.new
  end

  def self.order(ids)
    update_all(
               ['item_order = FIND_IN_SET(id, ?)', ids.join(',')],
               { :id => ids }
               )
  end
  
  private

  def update_header
    self.header = self.name if self.header.blank?
  end
end
