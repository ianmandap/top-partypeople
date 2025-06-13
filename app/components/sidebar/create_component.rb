# frozen_string_literal: true

module Sidebar
  class CreateComponent < ViewComponent::Base
    def initialize(event:)
      @event = event
    end
  end
end
