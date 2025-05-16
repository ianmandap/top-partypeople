# frozen_string_literal: true

class AvatarPlaceholderComponent < ViewComponent::Base
  def initialize(placeholder_initial:)
    @placeholder_initial = placeholder_initial
  end
end
