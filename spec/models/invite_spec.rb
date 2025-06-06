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
require 'rails_helper'

RSpec.describe Invite, type: :model do
  subject(:invite) { build(:invite) }

  describe 'associations' do
    it { is_expected.to belong_to(:attendee).class_name('User') }
    it { is_expected.to belong_to(:event).class_name('Event') }
    it { is_expected.to have_one(:creator).through(:event) }
  end

  context 'with valid attributes' do
    it { is_expected.to be_valid }

    it do
      is_expected.to define_enum_for(:status).
                     with_values([ :pending, :attending, :maybe, :declined, :waitlist ]).
                     backed_by_column_of_type(:integer)
    end

    it "is expected that event host cannot be an attendee" do
      user = FactoryBot.create(:user)
      event = FactoryBot.create(:event, creator: user)

      subject.event = event
      subject.attendee = user

      expect(subject.valid?).to eq(false)
      expect(subject.errors[:attendee][0]).to eq("is not valid. Event host cannot be an attendee")
    end
  end
end
