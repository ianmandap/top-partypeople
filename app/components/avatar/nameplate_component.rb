# frozen_string_literal: true

module Avatar
  class NameplateComponent < ViewComponent::Base
    def initialize(event:)
      @event = event
    end
  end
end
