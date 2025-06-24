# frozen_string_literal: true

class EventsCardComponent < ViewComponent::Base
  def initialize(events:, user:)
    @events = events
    @user = user
  end

  private

  def poster_path(event)
    "/posters/#{event.display_poster}"
  end

  def display_date_and_time(event)
    helpers.formatted_date_and_time_short(event.start_date)
  end

  def display_user_status_on_event(event)
    return "" if event.nil? || @user.nil?

    if event.creator_id == @user.id
      event.past? ? return "👑 HOSTED" : return "👑 HOSTING"
    end

    invite = event.invites.find_by(attendee: @user)
    return "OPEN INVITE" if invite.nil?

    case invite.status
    when "pending"
      event.past? ? "😢 DID NOT GO" : "⏳ PENDING"
    when "going"
      event.past? ? "👍 WENT" : "👍 WILL GO"
    when "maybe"
      event.past? ? "👍 WENT" : "🤔 MIGHT GO"
    when "declined"
      "❌ DECLINED"
    when "waitlist"
      event.past? ? "😢 DID NOT GO" : "⏳ WAITLIST"
    end
  end
end
