class Feature < ActiveRecord::Base
  has_many :options
  has_many :category_items, :as => :item, :dependent => :destroy
  has_many :categories, :through => :category_items

  validates_uniqueness_of :name, :message => 'Istnieje juz cecha o takiej nazwie.'
end
