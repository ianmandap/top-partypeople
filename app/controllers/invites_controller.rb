class InvitesController < ApplicationController
# before_action :ensure_frame_response, only: [ :index ]
before_action :set_event
before_action :set_invite, only: %i[ edit update destroy ]
before_action :authorize_user, except: %i[index]

def index
  # get attendee's invite or if creator stub invite for authorization
  @invite = Invite.find_by(attendee: Current.user, event: @event) || Invite.new(event: @event)
  authorize @invite

  @invites = Invite.includes(:attendee).where(event: @event)
end

def new
  @invite = Invite.new
end

def edit
end

def create
  @invite = Invite.new(invite_params)

  respond_to do |format|
    if @invite.save
      format.html { redirect_to @invite, notice: "Invite was successfully created." }
      format.json { render :show, status: :created, location: @invite }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @invite.errors, status: :unprocessable_entity }
    end
  end
end

def update
  respond_to do |format|
    if @invite.update(invite_params)
      format.html { redirect_to @invite, notice: "Invite was successfully updated." }
      format.json { render :show, status: :ok, location: @invite }
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @invite.errors, status: :unprocessable_entity }
    end
  end
end

def destroy
  @invite.destroy!

  respond_to do |format|
    format.html { redirect_to invites_path, status: :see_other, notice: "Invite was successfully destroyed." }
    format.json { head :no_content }
  end
end

private
  def ensure_frame_response
    return unless Rails.env.development?
    redirect_back(fallback_location: root_path) unless turbo_frame_request?
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
