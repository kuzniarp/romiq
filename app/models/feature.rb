class Feature < ActiveRecord::Base
  has_many :options

  validates_uniqueness_of :name, :message => 'Istnieje juz cecha o takiej nazwie.'
end
