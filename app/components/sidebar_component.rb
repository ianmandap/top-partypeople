# frozen_string_literal: true

class SidebarComponent < ViewComponent::Base
  def initialize(event:, form:)
    @event = event
    @form = form
  end

  private

  def edit_event?
    Pundit.policy(Current.user, @event).edit?
  end

  def update_event?
    Pundit.policy(Current.user, @event).update?
  end
end
