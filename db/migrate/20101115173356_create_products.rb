class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.text :description
      t.boolean :status, :default => 0
      t.string :permalink
      t.string :image_file_name
      t.string :image_content_type
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
