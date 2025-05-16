class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"

  validates :title, presence: true
  validates :date, presence: true
  validates :location, presence: true

  def formatted_date
    date.strftime("%A, %B %d, %Y %I:%M %p")
  end
end
