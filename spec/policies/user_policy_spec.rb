require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  let(:user) { FactoryBot.create(:user) }
  let(:userOther) { FactoryBot.create(:user) }

  subject { described_class }

  permissions :update? do
    it "grants access if user is self" do
      expect(subject).to permit(user, user)
    end

    it "does NOT grant access if a random user" do
      expect(subject).not_to permit(userOther, user)
    end
  end

  permissions :destroy? do
    it "grants access if user is self" do
      expect(subject).to permit(user, user)
    end

    it "does NOT grant access if a random user" do
      expect(subject).not_to permit(userOther, user)
    end
  end
end
