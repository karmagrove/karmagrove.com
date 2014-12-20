class EventDiscount < ActiveRecord::Base
  belongs_to :event
  attr_accessible :code, :price
end
