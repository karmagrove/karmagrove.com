class AddPaidAndPaidDescriptionToPurchase < ActiveRecord::Migration
  def change
  	add_column :purchases, :paid, :boolean
  	add_column :purchases, :paid_description, :text
  end
end
