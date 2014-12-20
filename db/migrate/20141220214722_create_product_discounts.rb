class CreateProductDiscounts < ActiveRecord::Migration
  def change
    create_table :product_discounts do |t|
      t.string :code
      t.integer :price
      t.references :product

      t.timestamps
    end
    add_index :product_discounts, :product_id
  end
end
