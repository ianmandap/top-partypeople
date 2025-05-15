class EventsController < ApplicationController
  allow_unauthenticated_access only: [ :index ]

  def index
    @events = Event.all
  end
end
