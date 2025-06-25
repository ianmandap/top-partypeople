# frozen_string_literal: true

module Buttons
  class CopyLinkComponent < ViewComponent::Base
    def initialize(event:)
      @event = event
    end
  end
end
