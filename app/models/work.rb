class Work < ActiveRecord::Base

  has_many :pictures, :as => :assetable

end
