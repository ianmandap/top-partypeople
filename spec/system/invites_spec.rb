require 'rails_helper'

RSpec.describe "Invites flow", type: :system, js: true do
  include_context 'logged in user with events'

  context 'with unregistered user' do
    it "can rsvp in public events" do
      visit events_path
      find("#event-cards-container").find('a', match: :first).click

      expect(page).to have_selector('#label-indicator-going')
      expect(page).to have_selector('#label-indicator-maybe')
      expect(page).to have_selector('#label-indicator-declined')

      click_on "Going"
      expect(page).to have_text("Sign up to save")
    end

    it "can accept an Invite but is prompted to sign up first" do
      new_event = FactoryBot.create(:event, is_public: false)
      visit event_path(new_event)
      click_on "Going"

      expect(page).to have_text("Sign up to save your details")
      find('#user-display-name').set("Maya Angelou")
      find('#user-email-address').set("maya@mail.com")
      find('#user-password').set("password")
      find('#user-password-confirmation').set("password")
      click_on("Submit", match: :first)

      click_on "Going"
      expect(page).to have_text("RSVP Options")
      find('#label-invite-going').click
      click_on "Create Invite"

      expect(page).to have_text("Guest List")
      expect(page).to have_text("1 Going")
      expect(page).to have_selector('#label-indicator-going')
    end
  end

  context 'with authenticated user on an event they are attending' do
    before do
      FactoryBot.create_list(:invite, 1, event: attending_event, status: :going)
      FactoryBot.create_list(:invite, 1, event: attending_event, status: :maybe)
      FactoryBot.create_list(:invite, 1, event: attending_event, status: :declined)

      selenium_login(user)
      visit event_path(attending_event)
      expect(page).to have_selector('#label-indicator-going')
      expect(page).not_to have_selector('#label-indicator-maybe')
    end

    it 'can interact with guest list' do
      click_on "View All"

      guest_list = Invite.guest_list(attending_event.id)
      guest_list[:going].each do |name|
        expect(page).to have_text(name)
      end
      expect(page).to have_text("Going #{guest_list[:going].count}")
      expect(page).to have_text("Declined #{guest_list[:declined].count}")
    end

    it "can edit their invite" do
      click_on "👍"
      expect(page).to have_text("Editing Invite")
      find('#label-invite-maybe').click
      click_on "Update Invite"

      expect(page).not_to have_selector('#label-indicator-going')
      expect(page).to have_selector('#label-indicator-maybe')
    end

    it 'can delete their invite' do
      click_on "👍"
      expect(page).to have_text("Editing Invite")
      click_on "Delete Invite"
      page.accept_alert

      expect(page).not_to have_text("Guest List")
      expect(page).to have_selector('#label-indicator-going')
      expect(page).to have_selector('#label-indicator-maybe')
      expect(page).to have_selector('#label-indicator-declined')
    end
  end
end
