module EventsHelper
  def hosting?(event:)
    event.creator&.id == Current.user.id
  end

  def display_user_status_on_event(event:, user:)
    return "" if event.nil? || user.nil?

    if event.creator_id == user.id
      event.past? ? "👑 HOSTED" : "👑 HOSTING"
    elsif event.attendee_ids.include?(user.id)
      # TODO:check invitation status
      event.past? ? "👍 WENT" : "👍 WILL GO"
      # "😢 DID NOT GO"
    else
      event.past? ? "" : "OPEN INVITE"
    end
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
end
