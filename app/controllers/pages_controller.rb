class PagesController < ApplicationController
  allow_unauthenticated_access only: [ :home, :about, :demo ]
  def home
    redirect_to user_path(id: Current.user.id) if authenticated?
  end

  def about
  end

  def demo
    unless authenticated?
      user = User.find_by(email_address: "user@example.com")
      start_new_session_for user
      redirect_to user_path(user) and return
    end

    redirect_to root_path
  end
end
