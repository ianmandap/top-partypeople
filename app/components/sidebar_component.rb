# frozen_string_literal: true

class SidebarComponent < ViewComponent::Base
  def initialize(event:)
    @event = event
  end

  private

  def edit_event?
    Pundit.policy(Current.user, @event).edit? && helpers.on_event_path?
  end

  def update_event?
    Pundit.policy(Current.user, @event).update? && helpers.on_edit_event_path?
  end
end
