# frozen_string_literal: true

class SidebarComponent < ViewComponent::Base
  def initialize(event:)
    @event = event
  end
end
