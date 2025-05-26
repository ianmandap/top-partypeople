# frozen_string_literal: true

class JumbotronComponent < ViewComponent::Base
  def initialize(title:, text:)
    @title = title
    @text = text
  end
end
