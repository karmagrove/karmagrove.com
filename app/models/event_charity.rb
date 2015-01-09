class EventCharity < ActiveRecord::Base
  belongs_to :event
  belongs_to :charity
  
  attr_accessible :event_id, :charity_id
end
