# frozen_string_literal: true

class NavBarListItemComponent < ViewComponent::Base
  def initialize(name:, path:)
    @name = name
    @path = path
  end
end
