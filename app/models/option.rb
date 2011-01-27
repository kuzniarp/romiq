class Option < ActiveRecord::Base
  belongs_to :feature
  has_many :pictures, :as => :assetable
end
