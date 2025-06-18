class InvitePolicy < ApplicationPolicy
  attr_reader :user, :invite

  def initialize(user, invite)
    @user = user
    @invite = invite
  end

  def index?
    creator? || attendee?
  end

  def new?
    attendee?
  end

  def create?
    attendee?
  end

  def update?
    creator? || attendee?
  end

  def destroy?
    creator? || attendee?
  end

  private

  def attendee?
    user == invite.attendee
  end

  def creator?
    user == invite.creator
  end
end
