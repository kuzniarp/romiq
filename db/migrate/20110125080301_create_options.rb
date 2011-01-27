class CreateOptions < ActiveRecord::Migration
  def self.up
    create_table :options do |t|
      t.string :name
      t.string :color_code
      t.integer :feature_id
      t.timestamps
    end
  end

  def self.down
    drop_table :options
  end
end
