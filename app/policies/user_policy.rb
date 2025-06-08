class UserPolicy < ApplicationPolicy
  attr_reader :user, :userRecord

  def initialize(user, userRecord)
    @user = user
    @userRecord = userRecord
  end

  def update?
    user == userRecord
  end

  def destroy?
    user == userRecord
  end
end
