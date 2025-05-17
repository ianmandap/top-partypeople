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
class User < ApplicationRecord
  has_secure_password

  has_many :sessions, dependent: :destroy
  has_many :events, foreign_key: "creator_id", dependent: :destroy
  has_many :invites, foreign_key: "attendee_id"
  has_many :attended_events, through: :invites, source: :event

  validates :email_address, uniqueness: true, presence: true
  validates :display_name, presence: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def placeholder_initial
    display_name[0]
  end
end
