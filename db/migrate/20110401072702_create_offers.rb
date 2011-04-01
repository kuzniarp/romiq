class CreateOffers < ActiveRecord::Migration
  def self.up
    create_table :offers do |t|
      t.string :name
      t.text :description
      t.boolean :status, :default => 0
      t.timestamps
    end
    create_table :offer_items do |t|
      t.integer :offer_id
      t.integer :item_id
      t.integer :item_type
    end
  end

  def self.down
    drop_table :offers
    drop_table :offer_items
  end
end
