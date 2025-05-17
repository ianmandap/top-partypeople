module ApplicationHelper
  def active?(path)
    request.path == path
  end

  def formatted_date(date)
    date.strftime("%A, %B %d, %Y")
  end

  def formatted_time(date)
    date.strftime("%I:%M %p")
  end
end
