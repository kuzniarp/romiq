class CreateCategoryItems < ActiveRecord::Migration
  def self.up
    create_table :category_items do |t|
      t.integer :category_id, :item_id, :item_type
    end
    add_index :category_items, [:category_id, :item_id, :item_type], :unique => true
  end

  def self.down
    drop_table :category_items
  end
end
