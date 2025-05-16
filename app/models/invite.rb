class Invite < ApplicationRecord
  belongs_to :attendee, class_name: "User"
  belongs_to :event, class_name: "Event"
  has_one :creator, through: :event, foreign_key: "creator_id"

  enum :status, {
    pending: 0,
    attending: 1,
    maybe: 2,
    declined: 3,
    waitlist: 4
  }

  validates :is_invited, inclusion: [ true, false ]
end
