module EventsHelper
  def guest_list_subtext(invites:)
    maybe_count = invites.maybe.count
    text = "#{invites.attending.count} Going"
    text += " | #{maybe_count} Maybe" unless maybe_count.zero?

    text
  end

  def array_of_display_posters
    Dir.entries(Rails.root.join("public/posters")) - [ ".", ".." ]
  end

  def on_new_event_path?
    request.path == new_event_path
  end

  def on_event_path?
    return false if params[:id].nil?
    request.path == event_path
  end

  def on_edit_event_path?
    return false if params[:id].nil?
    request.path == edit_event_path
  end

  def display_user_status_on_event(event:, user:)
    return "" if event.nil? || user.nil?

    if event.creator_id == user.id
      event.past? ? return "👑 HOSTED" : return "👑 HOSTING"
    end

    invite = Invite.find_by(event: event, attendee: user)
    return "OPEN INVITE" if invite.nil?

    case invite.status
    when "pending"
      event.past? ? "😢 DID NOT GO" : "⏳ PENDING"
    when "attending"
      event.past? ? "👍 WENT" : "👍 WILL GO"
    when "maybe"
      event.past? ? "👍 WENT" : "🤔 MIGHT GO"
    when "declined"
      "DECLINED"
    when "waitlist"
      event.past? ? "😢 DID NOT GO" : "⏳ WAITLIST"
    end
  end
end
