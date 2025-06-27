require 'rails_helper'

RSpec.describe "Sessions flow", type: :system do
  let!(:user) { FactoryBot.create(:user, display_name: "John Delta", email_address: "john@mail.com") }

  scenario "Unregistered user signs up" do
    visit root_path
    click_on("Login", match: :first)
    click_on "Not registered?"

    expect(page).to have_text("Sign Up")
    find('#user-display-name').set("Maya Angelou")
    find('#user-email-address').set("maya@mail.com")
    find('#user-password').set("password")
    find('#user-password-confirmation').set("password")
    click_on("Submit", match: :first)

    expect(page).to have_text("Welcome back")
  end

  scenario "User signs in and is redirected to their User page" do
    visit root_path
    expect(page).to have_text("Create a Party in seconds")

    click_on("Login", match: :first)

    find('#email_address').set(user.email_address)
    find('#password').set(user.password)
    find('#login-button-new-session').click

    expect(page).to have_text("Welcome back, John Delta!")
  end

  scenario "Authenticated User signs out successfully" do
    selenium_login(user)

    find("#avatarButton").click
    find('#logout-nav-bar').click

    expect(page).to have_text("Create a Party in seconds")
  end
end
