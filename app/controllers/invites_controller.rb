class InvitesController < ApplicationController
before_action :ensure_frame_response, only: [ :index ]
before_action :set_user
before_action :set_event
before_action :set_invite, only: %i[ edit update destroy ]
before_action :authorize_user, only: %i[edit update destroy]

def index
  # get attendee's invite or if creator stub invite for authorization
  @invite = Invite.find_by(attendee: @user, event: @event) || Invite.new(event: @event)
  authorize @invite

  @invites = Invite.includes(:attendee).where(event: @event)
end

def new
  @invite = Invite.find_by(event: @event, attendee: @user)
  redirect_to edit_event_invite_path(@event, @invite) if @invite

  @invite = Invite.new
end

def edit
end

def create
  @invite = Invite.new(invite_params)
  @invite.attendee = @user
  @invite.event = @event
  # TODO: Implement host approval process
  @invite.is_approved = true

  respond_to do |format|
    if @invite.save
      # format.turbo_stream { render turbo_stream: turbo_stream.replace("invite", partial: "invites/invite", locals: { invite: @invite }) }
      format.html { redirect_to @event, notice: "Invite was successfully created." }
      format.json { render :show, status: :created, location: @event }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @invite.errors, status: :unprocessable_entity }
    end
  end
end

def update
  respond_to do |format|
    if @invite.update(invite_params)
      # format.turbo_stream { render turbo_stream: turbo_stream.replace("invite", partial: "invites/invite", locals: { invite: @invite }) }
      format.html { redirect_to @event, notice: "Invite was successfully updated." }
      format.json { render :show, status: :ok, location: @event }
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @invite.errors, status: :unprocessable_entity }
    end
  end
end

def destroy
  @invite.destroy!

  respond_to do |format|
    # format.turbo_stream { render turbo_stream: turbo_stream.remove(@invite) }
    format.html { redirect_to @event, status: :see_other, notice: "Invite was successfully destroyed." }
    format.json { head :no_content }
  end
end

private
  def ensure_frame_response
    return if Rails.env.development?
    redirect_back(fallback_location: root_path) unless turbo_frame_request?
  end

  def set_user
    @user = authenticated? && Current.user
  end

  def set_event
    @event = Event.find(params.expect(:event_id))
  end

  def set_invite
    @invite = Invite.find(params.expect(:id))
  end

  def invite_params
    params.expect(invite: [ :is_approved, :status ])
  end

  def authorize_user
    authorize @invite
  end
end
