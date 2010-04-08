class Page < ActiveRecord::Base

  has_permalink :name

  acts_as_tree :order => "item_order"

  named_scope :active, :conditions => {:status => true}

  before_save :update_header

  def to_param
    permalink
  end

  def self.menu_pages
    active.all(:conditions => {:parent_id => nil})
  end

  def self.home_page
    HomePage.first || HomePage.new
  end

  private

  def update_header
    self.header = self.name if self.header.blank?
  end
end
