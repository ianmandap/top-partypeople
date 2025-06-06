require 'rails_helper'

RSpec.describe EventPolicy, type: :policy do
  let(:user) { FactoryBot.create(:user) }
  let(:event) { FactoryBot.create(:event, creator: user) }

  subject { described_class }

  # permissions ".scope" do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :show? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :create? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  permissions :update? do
    it "grants access if user is event's creator" do
      expect(subject).to permit(user, event)
    end

    it "does NOT grant access if a random user" do
      expect(subject).not_to permit(FactoryBot.create(:user), event)
    end
  end

  permissions :destroy? do
    it "grants access if user is event's creator" do
      expect(subject).to permit(user, event)
    end

    it "does NOT grant access if a random user" do
      expect(subject).not_to permit(FactoryBot.create(:user), event)
    end
  end
end
