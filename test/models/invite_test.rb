# == Schema Information
#
# Table name: invites
#
#  id          :bigint           not null, primary key
#  is_invited  :boolean          default(FALSE), not null
#  status      :integer          default("pending")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  attendee_id :bigint
#  event_id    :bigint
#
# Indexes
#
#  index_invites_on_attendee_id  (attendee_id)
#  index_invites_on_event_id     (event_id)
#
require "test_helper"

class InviteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
