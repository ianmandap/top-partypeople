# frozen_string_literal: true

class JumbotronComponent < ViewComponent::Base
  renders_one :button
  renders_one :image

  def initialize(title:, text:)
    @title = title
    @text = text
  end
end
