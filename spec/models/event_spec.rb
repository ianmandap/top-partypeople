# == Schema Information
#
# Table name: events
#
#  id                   :uuid             not null, primary key
#  accommodation        :string
#  additional_info      :string
#  description          :text
#  display_poster       :string
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
#  creator_id           :uuid
#
# Indexes
#
#  index_events_on_creator_id  (creator_id)
#
# Foreign Keys
#
#  fk_rails_...  (creator_id => users.id)
#
require 'rails_helper'

RSpec.describe Event, type: :model do
  subject(:event) { build(:event) }

  describe 'associations' do
    it { is_expected.to belong_to(:creator).class_name('User') }
    it { is_expected.to have_many(:invites) }
    it { is_expected.to have_many(:attendees).through(:invites) }
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

    it 'is expected to normalize multiple attributes with empty string to nil' do
      [ :accommodation, :additional_info, :dress_code, :food_situation, :parking_instructions ].each do |attr|
        expect { normalize(attr).from("").to(nil) }
      end
    end
  end

  describe '.past' do
    it 'returns events with start_date in the past' do
      Event.destroy_all
      FactoryBot.create_list(:event, 2, :past)
      FactoryBot.create(:event)

      expect(Event.past.count).to eql(2)
    end
  end

  describe '.upcoming' do
    it 'returns events with start_date that are upcoming' do
      Event.destroy_all
      FactoryBot.create_list(:event, 2, :past)
      FactoryBot.create(:event)

      expect(Event.upcoming.count).to eql(1)
    end
  end
end
