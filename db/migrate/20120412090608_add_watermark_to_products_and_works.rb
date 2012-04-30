class AddWatermarkToProductsAndWorks < ActiveRecord::Migration
  def self.up
    add_column :products, :watermark, :boolean
    add_column :products, :watermark_2, :boolean
    add_column :works, :watermark, :boolean
    add_column :works, :watermark_2, :boolean
  end

  def self.down
    remove_column :products, :watermark
    remove_column :products, :watermark_2
    remove_column :works, :watermark
    remove_column :works, :watermark_2
  end
end
