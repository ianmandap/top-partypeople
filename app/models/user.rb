class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :events, foreign_key: "creator_id"

  validates :email_address, uniqueness: true, presence: true
  validates :display_name, presence: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
