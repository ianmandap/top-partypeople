class UsersController < ApplicationController
  allow_unauthenticated_access only: [ :new, :create ]
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :authorize_user, only: %i[ edit update destroy]

  # GET /users/1 or /users/1.json
  def show
    @upcoming = @user.upcoming_events
    @hosting = @user.events.upcoming.order(start_date: :asc)
    @attended_events = @user.attended_events.past.order(start_date: :desc)
    @past_events = @user.past_events
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        start_new_session_for @user
        format.html { redirect_to user_path(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_path, status: :see_other, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.includes(:events, :attended_events).find(params.expect(:id))
    end

    def user_params
      params.expect(user: [ :email_address, :password, :password_confirmation, :display_name ])
    end

    def authorize_user
      authorize @user
    end
end
