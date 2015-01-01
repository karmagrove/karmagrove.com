class Event < ActiveRecord::Base
  belongs_to :seller
  attr_accessible :address, :city, :description, :end_time, :image_url, :name, :price, :start_time, :state, :zip_code, :seller_id
end
