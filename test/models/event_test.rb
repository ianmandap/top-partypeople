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
require "test_helper"

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
