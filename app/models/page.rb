class Page < ActiveRecord::Base

  named_scope :active, :conditions => {:status => true}

  before_save :update_header

  def to_param
    permalink
  end

  def self.menu_pages
    active(:conditions => {:parent_id => nil})
  end

  def self.home_page
    HomePage.first || HomePage.new
  end

  private

  def update_header
    self.header = self.name if self.header.blank?
  end
end
