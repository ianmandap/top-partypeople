# frozen_string_literal: true

class AvatarStackComponent < ViewComponent::Base
  def initialize(attendees:)
    @attendees = attendees
  end
end
