class EventsController < ApplicationController
  allow_unauthenticated_access only: [ :index, :new, :show ]
  before_action :set_user
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :authorize_user, only: %i[edit update destroy]

  def index
    @events = Event.includes(:creator, :invites).is_public.upcoming.order(start_date: :asc)
  end

  def show
    @invite = Invite.find_by(attendee: Current.user, event: @event)
    @invites = @event.invites
    @accepted_count = @invites.accepted.count || 0
  end

  def new
    @event = Event.new
    @event.creator = Current.user
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
        format.html {
          # workaround for datepicker.js needing a full refresh preventing @event.errors from being seen
          flash[:alert] = @event.errors
          render :new, status: :unprocessable_entity
         }
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
        format.html {
          flash[:alert] = @event.errors
          render :edit, status: :unprocessable_entity
         }
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
  def set_user
    @user = authenticated? && Current.user
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.includes(:invites, :attendees).find(params.expect(:id))
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
