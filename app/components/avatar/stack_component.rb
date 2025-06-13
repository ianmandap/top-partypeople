# frozen_string_literal: true

module Avatar
  class StackComponent < ViewComponent::Base
    MAX_AVATAR_NUMBER = 5

    def initialize(invites:)
      @invites = invites
    end

    private

    def max?(idx)
      idx == MAX_AVATAR_NUMBER && @invites.size > MAX_AVATAR_NUMBER
    end

    def users_left_string
      "#{@invites.size - MAX_AVATAR_NUMBER}+"
    end
  end
end
