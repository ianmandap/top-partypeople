# frozen_string_literal: true

class AvatarsStackModalComponent < ViewComponent::Base
  def initialize(size:, attendees:)
    @size = size
    @attendees = attendees
  end
end
