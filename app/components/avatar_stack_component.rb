# frozen_string_literal: true

class AvatarStackComponent < ViewComponent::Base
  def initialize(attendees:, modal_id:)
    @modal_id = modal_id
    @attendees = attendees
  end
end
