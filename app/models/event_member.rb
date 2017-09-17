class EventMember < ActiveRecord::Base

  belongs_to :event
  belongs_to :user
  belongs_to :group

end
