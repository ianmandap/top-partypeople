# frozen_string_literal: true

class VideoComponent < ViewComponent::Base
  def initialize(filename:)
    @filename = filename
  end

  erb_template <<~ERB
    <%= video_tag @filename, autoplay: true, loop: true, muted: true, class: "w-full h-full" %>
  ERB
end
