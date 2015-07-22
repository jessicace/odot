require 'rails_helper'

describe "logging in" do
  it "logs the user in and goes to the todo lists" do
    User.create(first_name: "Jessica", last_name: "Edwards", email: "jessica@eml.cc", password: "jessica", password_confirmation: "jessica")
    visit "/"
    click_link "Log In"
    fill_in "Email Address", with: "jessica@eml.cc"
    fill_in "Password", with: "jessica"
    click_button "Log In"

    expect(page).to have_content("Todo Lists")
    expect(page).to have_content("Thanks for logging in!")
  end

  it "displays the email address in the event of a failed login" do
    visit new_user_session_path
    fill_in "Password", with: "incorrect"
    click_button "Log In"

    expect(page).to have_content("Please check your email and password")
    expect(page).to have_field("Email Address", with: "jessica@eml.cc")
  end
end
