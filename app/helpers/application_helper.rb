module ApplicationHelper
  def active?(path)
    request.path == path
  end

  def formatted_date(date)
    date.strftime("%A, %b %d")
  end

  def formatted_time(date)
    date.strftime("%-I:%M %p")
  end

  def formatted_date_and_time(date)
    if date.strftime("%M") == "00"
      date.strftime("%a %-m/%-d · %l%P")
    else
      date.strftime("%a %-m/%-d · %l:%M%P")
    end
  end
end
