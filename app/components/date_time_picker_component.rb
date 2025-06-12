# frozen_string_literal: true

class DateTimePickerComponent < ViewComponent::Base
  def initialize(event:, form:)
    @event = event
    @form = form
  end

  private

  def picker_value
    @event.start_date? ? helpers.formatted_date_and_time_long(@event.start_date) : nil
  end

  def date_value
    @event.start_date? ? helpers.formatted_date_iso(@event.start_date) : nil
  end

  def time_value
    @event.start_date? ? helpers.formatted_time_long(@event.start_date) : nil
  end
end
