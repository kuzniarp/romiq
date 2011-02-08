class CreateOptionCombinationPictures < ActiveRecord::Migration
  def self.up
    create_table :option_combination_pictures do |t|
      t.integer :option_combination_id
      t.integer :picture_id
    end
    add_index :option_combination_pictures, [:option_combination_id, :picture_id], :unique => true, :name => 'index_on_option_combination_id_and_picture_id'
  end

  def self.down
    drop_table :option_combination_pictures
  end
end
