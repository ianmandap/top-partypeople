# frozen_string_literal: true

class EventsCardComponent < ViewComponent::Base
  def initialize(events:)
    @events = events
  end
end
