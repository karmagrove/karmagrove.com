class EventTicket < Product
  # attr_accessible :title, :body
  has_many :event_purchases
end
