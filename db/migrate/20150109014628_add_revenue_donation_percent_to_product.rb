class AddRevenueDonationPercentToProduct < ActiveRecord::Migration
  def change
  	add_column :products, :revenue_donation_percent, :integer
  end
end
