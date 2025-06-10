# frozen_string_literal: true

class AvatarStackComponent < ViewComponent::Base
  def initialize(invites:)
    @invites = invites
  end
end
