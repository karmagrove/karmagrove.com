class AddCostToPurchaseandPaymentHrefToPurchase < ActiveRecord::Migration
  def change
  	add_column :batches, :cost, :integer
  	add_column :batches, :profit_donation_percent, :integer
  	add_column :batches, :revenue_donation_percent, :integer
  	add_column :purchases, :payment_href, :string
  	add_column :users, :balanced_href, :string
  end
end
