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
class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :invites, dependent: :destroy
  has_many :attendees, through: :invites, source: :attendee

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, comparison: { greater_than: :start_date }, allow_blank: true
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

  def self.having_invites(count: 1)
    joins(:invites).group(:id).having("count(invites.id) > ?", count)
  end
end
