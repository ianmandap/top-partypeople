# frozen_string_literal: true

class VideoComponent < ViewComponent::Base
  def initialize(filename:)
    @filename = filename
  end
end
