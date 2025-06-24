# frozen_string_literal: true

module RSVP
  class ChoicesComponent < ViewComponent::Base
    def initialize(invite: nil)
      @invite = invite
    end

    private

    def checked?(status_name)
      @invite && @invite.send(status_name.to_sym)
    end

    def checkHidden(status_name)
      if @invite.nil? || @invite.send(status_name.to_sym)
        false
      else
        "hidden"
      end
    end
  end
end
