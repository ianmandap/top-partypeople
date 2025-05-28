class PagesController < ApplicationController
  allow_unauthenticated_access only: [ :home, :about ]
  def home
    redirect_to user_path(id: Current.user.id) if authenticated?
  end

  def about
  end
end
