class Page < ActiveRecord::Base

  def to_param
    permalink
  end

  def self.menu_pages
    all(:conditions => {:parent_id => nil})
  end
end
