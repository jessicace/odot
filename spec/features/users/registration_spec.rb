require 'rails_helper'

describe "Signing up" do
  it "allows a user to sign up for the site and creates the object in the database" do
    expect(User.count).to eq(0)

    visit "/"
    expect(page).to have_content("Sign Up")
    click_link "Sign Up"

    fill_in "First name", with: "Jessica"
    fill_in "Last name", with: "Edwards"
    fill_in "Email", with: "jessica@eml.cc"
    fill_in "Password", with: "jessica"
    fill_in "Password confirmation", with: "jessica"
    click_button "Sign Up"

    expect(User.count).to eq(1)
  end
end
