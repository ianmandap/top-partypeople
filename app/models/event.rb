class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"

  validates :date, presence: true
  validates :location, presence: true
end
