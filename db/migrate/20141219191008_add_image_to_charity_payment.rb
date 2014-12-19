class AddImageToCharityPayment < ActiveRecord::Migration
  def change
  	 add_column :charity_payments, :payment_url, :string
  	 add_column :charity_payments, :payment_image_url, :string
  end
end
