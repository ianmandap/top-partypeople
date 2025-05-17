module ApplicationHelper
  def active?(path)
    request.path == path
  end
end
