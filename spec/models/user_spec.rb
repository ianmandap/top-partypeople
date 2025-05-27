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
end
