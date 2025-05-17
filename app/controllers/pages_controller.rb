class PagesController < ApplicationController
  allow_unauthenticated_access only: [ :home, :about ]
  def home
  end

  def about
  end
end
