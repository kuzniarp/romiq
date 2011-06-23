class Page < ActiveRecord::Base

  has_permalink :name
  has_many :pictures, :as => :assetable
  
  acts_as_tree :order => "pages.item_order"

  named_scope :active, :conditions => {:status => true}

  named_scope :with_pictures, :include => :pictures, :conditions => "assets.id is not null"

  before_save :update_header

  attr_accessor :order_number

  def to_param
    permalink
  end

  def order_number
    @order_number ||= item_order
  end

  def self.menu_pages
    pages = active.all(:conditions => {:parent_id => nil})
    pages << ProductPage.new(:name => "Produkty", :permalink => "produkty", :order_number => 1.1)
    pages << WorkPage.new(:name => "Galeria", :permalink => "galeria", :order_number => 1.2)
    pages << OfferPage.new(:name => "Promocje", :permalink => "promocje", :order_number => 1.3)
    pages.sort_by(&:order_number)
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
