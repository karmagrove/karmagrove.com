class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.string :image_url
      t.references :seller
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip_code
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
    add_index :events, :seller_id
  end
end
