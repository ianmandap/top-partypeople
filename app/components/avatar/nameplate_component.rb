# frozen_string_literal: true

module Avatar
  class NameplateComponent < ViewComponent::Base
    def initialize(event:, is_authenticated: true)
      @event = event
      @is_authenticated = is_authenticated
    end
  end
end
