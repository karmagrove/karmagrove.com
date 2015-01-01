class CreateEventhosts < ActiveRecord::Migration
  def change
    create_table :eventhosts do |t|
      t.references :event
      t.references :user
      t.boolean :admin
      t.boolean :creator
      t.text :event_bio

      t.timestamps
    end
    add_index :eventhosts, :event_id
    add_index :eventhosts, :user_id
  end
end
