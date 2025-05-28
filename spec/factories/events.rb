# == Schema Information
#
# Table name: events
#
#  id                   :bigint           not null, primary key
#  accommodation        :string
#  additional_info      :string
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
FactoryBot.define do
  factory :event do
    association :creator, factory: :user
    title                { Faker::Book.title }
    start_date           { Random.rand(3..12).days.from_now }
    description          { Faker::Lorem.paragraph_by_chars * 5 }
    location             { Faker::Address.street_address }
    accommodation        { }
    additional_info      { Faker::Lorem.paragraph_by_chars }
    dress_code           { [ "Formal", "Casual", "Blacktie" ].sample }
    end_date             { start_date + 3.hours }
    food_situation       { Faker::Food.ethnic_category }
    is_public            { true }
    max_capacity         { Random.rand(3..10) }
    parking_instructions { Faker::Lorem.paragraph_by_chars }
  end

  trait :past_event do
    start_date { 1.week.ago }
    end_date   { 1.week.ago + 3.hours }
  end
end
