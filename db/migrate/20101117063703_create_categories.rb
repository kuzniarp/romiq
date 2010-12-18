class CreateCategories < ActiveRecord::Migration
    def self.up
      create_table :categories, :force => true do |t|
        t.string :name, :description, :type
        t.integer :position

	t.integer :parent_id, :children_count, :ancestors_count, :descendants_count
        t.boolean :hidden
      end
    end

    def self.down
      drop_table :categories
    end
end
