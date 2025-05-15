class EventsController < ApplicationController
  allow_unauthenticated_access only: [ :index, :show ]

  def index
    @events = Event.all
  end

  def show
  end
end
