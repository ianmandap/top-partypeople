class EventsController < ApplicationController
  allow_unauthenticated_access only: [ :index, :new, :show ]
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :authorize_user, only: %i[edit update destroy]

  def index
    @user = authenticated? && Current.user
    @events = Event.is_public.upcoming.order(start_date: :asc)
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
      if @event.update(event_params)
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
    params.expect(event: [ :title, :display_poster, :location, :max_capacity, :food_situation, :dress_code, :accommodation,
                           :parking_instructions, :additional_info, :description, :start_date, :end_date, :is_public ])
  end

  def authorize_user
    authorize @event
  end
end
