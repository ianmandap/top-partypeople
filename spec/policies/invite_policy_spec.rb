require 'rails_helper'

RSpec.describe InvitePolicy, type: :policy do
  let(:creator) { FactoryBot.create(:user) }
  let(:attendee) { FactoryBot.create(:user) }
  let(:event) { FactoryBot.create(:event, creator: creator) }
  let(:invite) { FactoryBot.create(:invite, event: event, attendee: attendee) }

  subject { described_class }

  permissions :index? do
    it "grants access if user is invite's event creator" do
      expect(subject).to permit(creator, invite)
    end

    it "grants access if user is attendee" do
      expect(subject).to permit(attendee, invite)
    end
    it "does NOT grant access if unregistered user" do
      expect(subject).not_to permit(User.new, invite)
    end
  end

  permissions :update? do
    it "grants access if user is invite's attendee" do
      expect(subject).to permit(attendee, invite)
    end

    it "does NOT grant access if a random user" do
      expect(subject).not_to permit(FactoryBot.create(:user), invite)
    end
  end

  permissions :destroy? do
    it "grants access if user is invite's attendee" do
      expect(subject).to permit(attendee, invite)
    end
    it "grants access if user is invite's event creator" do
      expect(subject).to permit(creator, invite)
    end

    it "does NOT grant access if a random user" do
      expect(subject).not_to permit(FactoryBot.create(:user), invite)
    end
  end
end
