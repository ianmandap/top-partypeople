module ApplicationHelper
  def active?(path)
    request.path == path
  end

  def creator?(event)
    current_user = authenticated? && Current.user
    current_user.id == event.creator.id
  end

  def attendee?(event)
    current_user = authenticated? && Current.user
    event.attendee_ids.include?(current_user.id)
  end
end
