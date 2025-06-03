module EventsHelper
  def hosting?(event:)
    event.creator&.id == Current.user.id
  end

  def display_user_status_on_event(event:, user:)
    return "NIL" if event.nil? || user.nil?

    if event.creator_id == user.id
      event.past? ? "👑 HOSTED" : "👑 HOSTING"
    else
      # Not hosting event ergo attended the event
      event.past? ? "👍 WENT" : "👍 WILL GO"
    end
    # "😢 DID NOT GO"
  end

  def array_of_cover_images
    Dir.entries(Rails.root.join("app/assets/images/posters")) - [ ".", ".." ]
  end
end
