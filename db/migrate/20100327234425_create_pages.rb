class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :name
      t.string :header
      t.text :body
      t.integer :item_order
      t.integer :parent_id
      t.string :permalink
      t.boolean :status, :default => 0
      t.string :type
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
