# == Schema Information
#
# Table name: invites
#
#  id          :bigint           not null, primary key
#  is_approved :boolean          default(FALSE), not null
#  status      :integer          default("pending")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  attendee_id :uuid
#  event_id    :uuid             not null
#
# Indexes
#
#  index_invites_on_attendee_id  (attendee_id)
#  index_invites_on_event_id     (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (attendee_id => users.id)
#  fk_rails_...  (event_id => events.id)
#
class Invite < ApplicationRecord
  belongs_to :attendee, class_name: "User"
  belongs_to :event, class_name: "Event"
  has_one :creator, through: :event, foreign_key: "creator_id"

  validate :attendee_cannot_be_creator

  enum :status, {
    pending: 0,
    attending: 1,
    maybe: 2,
    declined: 3,
    waitlist: 4,
  }

  def attendee_cannot_be_creator
    if creator == attendee
      errors.add(:attendee, "is not valid. Event host cannot be an attendee")
    end
  end

  scope :accepted, -> { where(status: :attending).or(self.where(status: :maybe)) }
end
