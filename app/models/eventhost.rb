class Eventhost < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  attr_accessible :admin, :creator, :event_bio, :event_id, :user_id
end
