class AddItemOrderToAssets < ActiveRecord::Migration
  def self.up
    add_column :assets, :item_order, :integer
  end
  
  def self.down
    remove_column :assets, :item_order
  end
end
