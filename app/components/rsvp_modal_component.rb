# frozen_string_literal: true

class RsvpModalComponent < ViewComponent::Base
  def initialize(invite: nil)
    @invite = invite
  end
end
