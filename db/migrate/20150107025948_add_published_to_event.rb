class AddPublishedToEvent < ActiveRecord::Migration
  def change
  	add_column :events, :published, :boolean
  	add_column :events, :url, :string
  	add_column :products, :quantity, :integer
  end
end
