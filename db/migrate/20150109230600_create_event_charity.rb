class CreateEventCharity < ActiveRecord::Migration
  def change
    create_table :event_charities do |t|
      t.references :event
	  t.references :charity
      t.timestamps
    end
    add_index :event_charities, :event_id
    add_index :event_charities, :charity_id
  end
end
