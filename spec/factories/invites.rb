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
FactoryBot.define do
  factory :invite do
    traits_for_enum :status

    association :event, factory: :event
    association :attendee, factory: :user
    status { :going }
  end
end
