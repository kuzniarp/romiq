require 'mime/types'
class Picture < Asset

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
  has_many :product_option_pictures, :dependent => :destroy
  has_attached_file :data,
                    :url  => "/assets/pictures/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/assets/pictures/:id/:style_:basename.:extension",
	                  :styles => { :content => '460x259#', :thumb => '100x100#' }
	
	validates_attachment_size :data, :less_than=>2.megabytes
  validates_attachment_presence :data
  validates_attachment_content_type :data, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg']
  
  # Fix the mime types. Make sure to require the mime-types gem
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
end
