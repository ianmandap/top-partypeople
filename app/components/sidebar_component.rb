# frozen_string_literal: true

class SidebarComponent < ViewComponent::Base
  def initialize(event:, form:)
    @event = event
    @form = form
  end
end
