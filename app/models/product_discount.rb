class ProductDiscount < ActiveRecord::Base
  belongs_to :product
  attr_accessible :code, :price
end
