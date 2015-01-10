class Product < ActiveRecord::Base
  has_many :product_charities
  
  attr_accessible :description, :name, :price, :id, 
  :image_url, :quantity, :reference_id, :type, :revenue_donation_percent
  # dragonfly_accessor :photo  

  def description_display
  	if self.description.nil?
  		return "the name says it all"
  	end
  	self.description
  end
  def pretty_price
    printf('%.2f', price)
  end

  def new_qr_code
    @product = self
    qr_code_img = RQRCode::QRCode.new('http://www.google.com/', :size => 4, :level => :h ).to_img
    @product.update_attribute :image_url, qr_code_img.to_string
  end
end
