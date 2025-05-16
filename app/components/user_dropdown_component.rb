# frozen_string_literal: true

class UserDropdownComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
  end
end
