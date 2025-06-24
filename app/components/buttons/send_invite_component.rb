# frozen_string_literal: true

module Buttons
  class SendInviteComponent < ViewComponent::Base
    def initialize(event:)
      @event = event
    end
  end
end
