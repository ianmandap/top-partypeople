# frozen_string_literal: true

class GuestListComponent < ViewComponent::Base
  def initialize(invites:, turbo_id:, event:)
    @invites = invites
    @turbo_id = turbo_id
    @event = event
  end

  private

  def guest_list_subtext
    maybe_count = @invites.maybe.count
    text = "#{@invites.attending.count} Going"
    text += " · #{maybe_count} Maybe" unless maybe_count.zero?

    text
  end
end
