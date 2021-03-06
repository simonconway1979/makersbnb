require 'spec_helper'

RSpec.feature 'Sign up', :type => :feature do

include WebHelpers

  scenario "User can enter their details and account is added to database" do
    expect{sign_up_owner}.to change{User.count}.by(1)
  end

  scenario "User has to sign up with a valid email" do
    expect{sign_up_owner(email: "not_an_email")}.to change{User.count}.by(0)
  end

  scenario "User passwords have to match" do
    expect{sign_up_owner(password_confirm: "abc")}.to change{User.count}.by(0)
  end

  scenario "User cannot sign up without entering a password" do
    expect{sign_up_owner(password: "", password_confirm: "")}.to change{User.count}.by(0)
  end

  scenario "User cannot sign up without an email" do
    expect{sign_up_owner(email: "")}.to change{User.count}.by(0)
  end

  scenario "User email must be unique" do
    sign_up_owner
    expect{sign_up_owner}.to change{User.count}.by(0)
  end

  scenario "If not logged in, there should be no log out button" do
    visit("/users/new")
    expect(page).not_to have_button("Log out")
  end

  scenario "If logged in, you should be redirected to the listings page" do
    sign_up_owner
    log_in_owner
    visit("users/new")
    expect(current_path).to eq "/listings"
    expect(page).not_to have_button("Log in")
    expect(page).to have_button ("log out")
  end

end
