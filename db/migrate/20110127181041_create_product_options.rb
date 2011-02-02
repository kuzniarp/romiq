class CreateProductOptions < ActiveRecord::Migration
  def self.up
    create_table :product_options do |t|
      t.integer :product_id
      t.integer :option_id
      t.timestamps
    end
    create_table :product_option_pictures do |t|
      t.integer :product_option_id
      t.integer :picture_id
    end
  end

  def self.down
    drop_table :product_options
    drop_table :product_option_pictures
  end
end
