class CreateOptionCombinationsOptions < ActiveRecord::Migration
  def self.up
    create_table :option_combinations_options, :id => false do |t|
      t.integer :option_combination_id
      t.integer :option_id
    end
    add_index :option_combinations_options, [:option_combination_id, :option_id], :unique => true, :name => 'index_on_option_combination_id_and_option_id'
  end
  
  def self.down
    drop_table :option_combinations_options
  end
end
