require 'rails_helper'

RSpec.describe "Event creation", type: :system, js: true do
  include_context 'logged in user with events'

  context 'with unregistered user' do
    scenario "unregistered user can create an Event but is prompted to sign up first" do
      visit root_path
      click_on "Create Event"

      find('#event-title').set("New Party Title!")
      find('#calendar-input').set("Sat, Dec 21 · 7:00 PM")
      find('#event-location').set("House of Chocolate")
      find('#event-max-capacity').set("10")
      find('#event-description').set("Come party with me!")

      click_on("Create", match: :first)

      expect(page).to have_text("Sign up to save your details")

      find('#user-display-name').set("Maya Angelou")
      find('#user-email-address').set("maya@mail.com")
      find('#user-password').set("password")
      find('#user-password-confirmation').set("password")
      click_on("Submit", match: :first)

      expect(page).to have_text("Event was successfully created.")
    end
  end
end
