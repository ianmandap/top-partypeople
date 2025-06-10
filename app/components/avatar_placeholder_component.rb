# frozen_string_literal: true

class AvatarPlaceholderComponent < ViewComponent::Base
  def initialize(placeholder_initial:, size: 8, data_hash: {})
    @placeholder_initial = placeholder_initial
    @size = size
    @data_hash = data_hash
  end
end
