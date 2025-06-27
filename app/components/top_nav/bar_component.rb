# frozen_string_literal: true

module TopNav
  class BarComponent < ViewComponent::Base
    def initialize(user: nil)
      @user = user
    end

    private

    def determine_path
      if @user.nil? || !@user.persisted?
        root_path
      else
        user_path(@user)
      end
    end
  end
end
