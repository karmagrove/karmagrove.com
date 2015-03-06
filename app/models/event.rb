class Event < ActiveRecord::Base
  belongs_to :seller
  has_many :event_charities
  attr_accessible :address, :city, :description, :end_time, :image_url, :name, 
  :price, :start_time, :state, :zip_code, :seller_id, 
  :published, :total_donated, :workflow_state, :revenue_donation_percent, :total_sales
end
