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
FactoryBot.define do
  factory :event do
    association :creator, factory: :user
    title                { Faker::Book.title }
    display_poster       { (Dir.entries(Rails.root.join('public/posters')) - [ '.', '..' ]).sample }
    start_date           { Random.rand(3..12).days.from_now }
    description          { Faker::Lorem.paragraphs(number: rand(10..20)).join("\n") }
    location             { Faker::Address.street_address }
    accommodation        { Faker::Lorem.paragraph }
    additional_info      { Faker::Lorem.paragraph_by_chars }
    dress_code           { [ "Formal", "Casual", "Blacktie" ].sample }
    end_date             { start_date + 3.hours }
    food_situation       { Faker::Food.ethnic_category }
    is_public            { true }
    max_capacity         { Random.rand(3..10) }
    parking_instructions { Faker::Lorem.paragraph }
  end

  trait :past do
    start_date { 1.week.ago }
  end

  trait :no_optional_fields do
    accommodation        { }
    additional_info      { }
    dress_code           { }
    end_date             { }
    food_situation       { }
    parking_instructions { }
  end
end
