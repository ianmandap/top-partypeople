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
require 'rails_helper'

RSpec.describe Invite, type: :model do
  subject(:invite) { build(:invite) }

  describe 'associations' do
    it { is_expected.to belong_to(:attendee).class_name('User') }
    it { is_expected.to belong_to(:event).class_name('Event') }
  end
end
