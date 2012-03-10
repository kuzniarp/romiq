class Page < ActiveRecord::Base

  has_permalink :name
  has_many :pictures, :as => :assetable, :dependent => :destroy, :order => :item_order
  
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

module PermalinkFu
  class << self
    # This method does the actual permalink escaping.
    def escape(string)
      string = string.to_s.unpack("U*").map{|e| e == 322 ? 108 : e}.pack("U*") #l > l
      result = ActiveSupport::Multibyte::Chars.new(string.to_s).normalize(:kd).gsub(/[^\x00-\x7F]/,'').to_s
      #result = ((translation_to && translation_from) ? Iconv.iconv(translation_to, translation_from, string) : string).to_s
      #result.gsub!(/[^\x00-\x7F]+/, '') # Remove anything non-ASCII entirely (e.g. diacritics).
      result.gsub!(/[^\w_ \-]+/i,   '') # Remove unwanted chars.
      result.gsub!(/[ \-]+/i,      '-') # No more than one of the separator in a row.
      result.gsub!(/^\-|\-$/i,      '') # Remove leading/trailing separator.
      result.downcase!
      result.size.zero? ? random_permalink(string) : result
    rescue
      random_permalink(string)
    end
  end
end
