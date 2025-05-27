# == Schema Information
#
# Table name: invites
#
#  id          :bigint           not null, primary key
#  is_invited  :boolean          default(FALSE), not null
#  status      :integer          default("pending")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  attendee_id :bigint
#  event_id    :bigint
#
# Indexes
#
#  index_invites_on_attendee_id  (attendee_id)
#  index_invites_on_event_id     (event_id)
#
class Invite < ApplicationRecord
  belongs_to :attendee, class_name: "User"
  belongs_to :event, class_name: "Event"
  has_one :creator, through: :event, foreign_key: "creator_id"

  enum :status, {
    pending: 0,
    attending: 1,
    maybe: 2,
    declined: 3,
    waitlist: 4,
  }
end
