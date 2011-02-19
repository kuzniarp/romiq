class Texture < Picture
  has_attached_file :data,
  :url  => "/assets/pictures/:id/:style_:basename.:extension",
  :path => ":rails_root/public/assets/pictures/:id/:style_:basename.:extension",
  :styles => { :content => '100x100#', :thumb => '40x40#' }
end
