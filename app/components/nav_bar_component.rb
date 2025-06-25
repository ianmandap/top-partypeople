# frozen_string_literal: true

class NavBarComponent < ViewComponent::Base
  def initialize(user: nil)
    @user = user
  end

  private

  def determine_path
    @user ? user_path(@user) : root_path
  end
end
