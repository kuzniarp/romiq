class CreateWorks < ActiveRecord::Migration
  def self.up
    create_table :works do |t|
      t.string :name
      t.text :description
      t.integer :portfolio_id
      t.boolean :status, :default => 0
      t.integer :item_order
      t.string :permalink
      t.timestamps
    end
  end

  def self.down
    drop_table :works
  end
end
