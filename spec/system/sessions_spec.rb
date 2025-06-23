require 'rails_helper'

RSpec.describe "Sessions flow", type: :system do
  let!(:user) { FactoryBot.create(:user, display_name: "John Delta", email_address: "john@mail.com") }

  scenario "User signs in and is redirected to their User page" do
    visit root_path
    expect(page).to have_text("Create a Party in seconds")

    click_on "Login"

    find('#email_address').set(user.email_address)
    find('#password').set(user.password)
    click_button "Login"

    expect(page).to have_text("Welcome back, John Delta!")
  end

  scenario "Authenticated User signs out successfully" do
    selenium_login(user)

    find("#avatarButton").click
    find('#logout-nav-bar').click

    expect(page).to have_text("Create a Party in seconds")
  end
end
