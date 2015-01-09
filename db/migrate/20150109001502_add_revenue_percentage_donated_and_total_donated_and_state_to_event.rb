class AddRevenuePercentageDonatedAndTotalDonatedAndStateToEvent < ActiveRecord::Migration
  def change
    add_column :events, :revenue_donation_percent, :integer
  	add_column :events, :workflow_state, :string
  	add_column :events, :total_donated, :float
  	add_column :products, :reference_id, :integer
  	add_column :products, :type, :string
  end
  # add_index :products, :reference_id
end
