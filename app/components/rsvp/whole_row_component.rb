# frozen_string_literal: true

module RSVP
  class WholeRowComponent < ViewComponent::Base
    def initialize(invite: nil, event:)
      @invite = invite
      @event = event
    end
  end
end
