require 'mime/types'
class Picture < Asset
Paperclip::Interpolations
  # === List of columns ===
  #   id                : integer 
  #   data_file_name    : string 
  #   data_content_type : string 
  #   data_file_size    : integer 
  #   assetable_id      : integer 
  #   assetable_type    : string 
  #   type              : string 
  #   locale            : integer 
  #   user_id           : integer 
  #   created_at        : datetime 
  #   updated_at        : datetime 
  # =======================

  belongs_to :assetable, :polymorphic => true
  #has_many :product_option_pictures, :dependent => :destroy
  has_many :option_combination_pictures, :dependent => :destroy

  has_attached_file :data,
                    :url  => "/assets/pictures/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/assets/pictures/:id/:style_:basename.:extension",
                    :processors => [:watermark],
                    :styles => proc { |attachment|
                               {
                                 :flow => '520x292#',
                                 :gallery => {
                                           :geometry => '1000x1000>',
                                           :watermark_path => "#{RAILS_ROOT}/public/images/romiq_watermark.png",
                                           :watermark_path_2 => "#{RAILS_ROOT}/public/images/archon_watermark.png",
                                           :watermark => attachment.instance.assetable && attachment.instance.assetable.respond_to?(:watermark) && attachment.instance.assetable.watermark,
                                           :watermark_2 => attachment.instance.assetable && attachment.instance.assetable.respond_to?(:watermark_2) && attachment.instance.assetable.watermark_2,
                                           :dissolve => '45%'},
                                 :content => '356x200#',
      :thumb => '100x100#' }}
	validates_attachment_size :data, :less_than=>2.megabytes
  validates_attachment_presence :data
  validates_attachment_content_type :data, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg']
  
  # Fix the mime types. Make sure to require the mime-types gem

  before_save :set_item_order

  def swfupload_file=(file_data)
    file_data.content_type = MIME::Types.type_for(file_data.original_filename).to_s
    self.data = file_data
  end
	
	def url_content
	  url(:content)
	end
	
	def url_thumb
	  url(:thumb)
	end
	
	def to_json(options = {})
	  options[:methods] ||= []
	  options[:methods] << :url_content
	  options[:methods] << :url_thumb
	  super options
  end
  
  def set_item_order
    self.item_order = Asset.count(:conditions => ["assetable_type = ? and assetable_id = ?", assetable_type, assetable_id]) + 1
  end

  def self.order(ids)
    update_all(
               ['item_order = FIND_IN_SET(id, ?)', ids.join(',')],
               { :id => ids }
               )
  end  
end
