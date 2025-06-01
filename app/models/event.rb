# == Schema Information
#
# Table name: events
#
#  id                   :bigint           not null, primary key
#  accommodation        :string
#  additional_info      :string
#  cover_image          :string
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
class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :invites
  has_many :attendees, through: :invites, source: :attendee

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, numericality: { greater_than: :start_date }, allow_blank: true, if: Proc.new { |e| e.start_date.present? }
  validates :location, presence: true
  validates :description, presence: true

  # normalize empty strings to nil value
  [ :accommodation, :additional_info, :dress_code, :food_situation, :parking_instructions ].each do |attr|
    normalizes attr, with: -> { _1.presence }
  end

  scope :past, -> { where("start_date < ?", Time.current) }
  scope :upcoming, -> { where("start_date >= ?", Time.current) }
  scope :is_private, -> { where(is_public: false) }
  scope :is_public, -> { where(is_public: true) }

  def past?
    start_date < Time.current
  end
end
