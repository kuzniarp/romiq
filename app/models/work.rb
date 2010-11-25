class Work < ActiveRecord::Base

  has_many :pictures, :as => :assetable

  def image
      pictures.first
  end
end
