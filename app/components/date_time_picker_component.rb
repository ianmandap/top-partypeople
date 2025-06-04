# frozen_string_literal: true

class DateTimePickerComponent < ViewComponent::Base
  def initialize(event:, name:)
    @event = event
    @name = name
  end
end
