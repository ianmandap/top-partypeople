# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  display_name    :string           not null
#  email_address   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email_address  (email_address) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'associations' do
    it { is_expected.to have_many(:sessions) }
    it { is_expected.to have_many(:events) }
    it { is_expected.to have_many(:invites) }
    it { is_expected.to have_many(:attended_events).through(:invites) }
  end

  context 'with valid attributes' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:display_name) }
    it { is_expected.to validate_uniqueness_of(:email_address).case_insensitive }
    it { is_expected.to normalize(:email_address).from(" ME@XYZ.COM\n").to("me@xyz.com") }
  end

  describe '#upcoming_events' do
    it 'returns upcoming hosting events and upcoming will attend events' do
      FactoryBot.create_list(:event, 3, :past, creator: subject)
      created = FactoryBot.create(:event, creator: subject, start_date: 3.days.from_now)
      invitee = FactoryBot.create(:invite, attendee: subject, event: FactoryBot.create(:event, start_date: 1.day.from_now))

      expect(subject.events.upcoming.count).to eql(1)
      expect(subject.events.upcoming[0]).to eql(created)
      expect(subject.attended_events.upcoming.count).to eql(1)
      expect(subject.attended_events.upcoming[0]).to eql(invitee.event)
      expect(subject.upcoming_events.count).to eql(2)
    end
  end

  describe '#past_events' do
  it 'returns past hosted events and past attended events' do
    FactoryBot.create_list(:event, 3, creator: subject)
    created = FactoryBot.create(:event, :past, creator: subject)
    invitee = FactoryBot.create(:invite, attendee: subject, event: FactoryBot.create(:event, :past))

    expect(subject.events.past.count).to eql(1)
    expect(subject.events.past[0]).to eql(created)
    expect(subject.attended_events.past.count).to eql(1)
    expect(subject.attended_events.past[0]).to eql(invitee.event)
    expect(subject.past_events.count).to eql(2)
  end
end
end
