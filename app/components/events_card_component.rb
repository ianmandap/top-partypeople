# frozen_string_literal: true

class EventsCardComponent < ViewComponent::Base
  def initialize(events:, user:)
    @events = events
    @user = user
  end
end
