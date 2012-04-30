class InsertWatermarksToAppropriateProductsAndWorks < ActiveRecord::Migration
  def self.up
    archon_kitchens = ProductCategory.find_by_permalink('dla-domow-archon+').items
    archon_kitchens.each{|product| product.update_attributes(:watermark => true, :watermark_2 => true)}
    archon_kitchens.each{|product| product.pictures.each{|picture| picture.data.reprocess!}}
    galleries = Work.all
    galleries.each{|work| work.update_attribute(:watermark, true)}
    galleries.each{|work| work.pictures.each{|picture| picture.date.reprocess!}}
  end

  def self.down
  end
end
