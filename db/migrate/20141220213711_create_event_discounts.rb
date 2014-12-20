class CreateEventDiscounts < ActiveRecord::Migration
  def change
    create_table :event_discounts do |t|
      t.string :code
      t.integer :price
      t.references :event

      t.timestamps
    end
    add_index :event_discounts, :event_id
  end
end
