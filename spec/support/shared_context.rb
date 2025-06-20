RSpec.shared_context "logged in user with events" do
  let(:user) { FactoryBot.create(:user, display_name: "John Delta", email_address: "john@mail.com") }

  let!(:event) { FactoryBot.create(:event, creator: user, title: "Created") }
  let!(:attending_event) { FactoryBot.create(:event, :with_attendees, number: 1) }
  let!(:invite) { FactoryBot.create(:invite, event: attending_event, attendee: user) }
  let!(:random_event) { FactoryBot.create(:event, title: "Random") }
  let!(:random_invite) { FactoryBot.create(:invite, event: random_event) }
  let!(:event_with_attendees) { FactoryBot.create(:event, :with_attendees) }

  before do
    login(user)
  end
end
