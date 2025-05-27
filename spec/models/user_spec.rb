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

  context 'with valid attributes' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:display_name) }
    it { is_expected.to validate_uniqueness_of(:email_address).case_insensitive }
  end
end
