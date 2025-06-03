class EventsController < ApplicationController
  allow_unauthenticated_access only: [ :index, :new, :show ]
  before_action :set_event, only: %i[ show edit update destroy ]

  def index
    @events = Event.upcoming.order(start_date: :asc)
  end

  def show
    @attendees = @event.attendees
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @event.creator = Current.user

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(user_params)
        format.html { redirect_to @event, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to events_path, status: :see_other, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.expect(event: [ :title, :description, :date, :is_public, :location ])
  end
end
