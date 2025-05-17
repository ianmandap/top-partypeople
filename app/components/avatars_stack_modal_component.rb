# frozen_string_literal: true

class AvatarsStackModalComponent < ViewComponent::Base
  def initialize(size:, attendees:, modal_id:)
    @modal_id = modal_id
    @size = size
    @attendees = attendees
  end
end
