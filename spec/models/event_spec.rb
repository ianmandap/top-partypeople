# == Schema Information
#
# Table name: events
#
#  id                   :bigint           not null, primary key
#  accommodation        :string
#  additional_info      :string
#  description          :text
#  dress_code           :string
#  end_date             :datetime
#  food_situation       :string
#  is_public            :boolean          default(TRUE), not null
#  location             :string
#  max_capacity         :integer
#  parking_instructions :string
#  start_date           :datetime
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  creator_id           :bigint
#
# Indexes
#
#  index_events_on_creator_id  (creator_id)
#
require 'rails_helper'

RSpec.describe Event, type: :model do
  subject(:event) { build(:event) }

  describe 'associations' do
    it { is_expected.to belong_to(:creator).class_name('User') }
  end

  context 'with valid attributes' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:location) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:start_date) }

    it 'is expected to have a valid end_date' do
      subject.start_date = Time.current

      subject.end_date = nil
      expect(subject.valid?).to be(true)

      subject.end_date = 2.days.from_now
      expect(subject.valid?).to be(true)

      subject.end_date = 1.day.ago
      expect(subject.valid?).to be(false)
    end
  end
end
