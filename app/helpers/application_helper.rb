module ApplicationHelper
  def active?(path)
    request.path == path
  end

  def formatted_date_iso(date)
    date.strftime("%F")
  end

  def formatted_date(date)
    date.strftime("%A, %b %d")
  end

  def formatted_time(date)
    date.strftime("%-I:%M %p")
  end

  def formatted_time_long(date)
    date.strftime("%I:%M %p")
  end

  def formatted_date_and_time_short(date)
    if date.strftime("%M") == "00"
      date.strftime("%a %-m/%-d · %l%P")
    else
      date.strftime("%a %-m/%-d · %l:%M%P")
    end
  end

  def formatted_date_and_time_long(date)
    if date.strftime("%M") == "00"
      date.strftime("%a, %b %-d · %l%P")
    else
      date.strftime("%a, %b %-d · %l:%M%P")
    end
  end
end
