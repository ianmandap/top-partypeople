module EventsHelper
  def guest_list_subtext(invites:)
    maybe_count = invites.maybe.count
    text = "#{invites.attending.count} Going"
    text += " · #{maybe_count} Maybe" unless maybe_count.zero?

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
end
