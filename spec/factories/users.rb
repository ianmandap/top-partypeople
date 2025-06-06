# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
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
FactoryBot.define do
  factory :user do
    display_name   { Faker::Name.first_name }
    email_address  { Faker::Internet.email }
    password       { "password" }
  end
end
