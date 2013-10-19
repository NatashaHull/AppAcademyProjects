require 'spec_helper'

describe "the signup process" do
  before(:each) do
    visit new_user_url
  end

  it "has a new user page" do
    expect(page).to have_content("New User")
  end

  describe "signing up a user" do

    it "shows username on the homepage after signup" do
      fill_in "username", :with => "testing_username"
      fill_in "password", :with => "helloworld"
      click_on "Create User"
      expect(page).to have_content "testing_username"
    end

    it "redirects to signup page upon failure" do
      click_on "Create User"
      expect(page).to have_content "New User"
    end

    it "does not go to user page upon failure" do
      click_on "Create User"
      expect(page).not_to have_content "Welcome"
    end

    it "requires a username" do
      fill_in "password", :with => "helloworld"
      click_on "Create User"
      expect(page).to have_content("New User")
    end

    it "requires a password" do
      fill_in "username", :with => "testing_username"
      click_on "Create User"
      expect(page).to have_content("New User")
    end
  end
end

describe "logging in" do

  it "shows username on the homepage after login" do
    sign_up_as_hello_world
    click_button "Sign Out"

    visit "/session/new"
    sign_in_as_hello_world
    expect(page).to have_content("hello_world")
  end

  it "does not log in a user that doesn't exist" do
    visit new_session_url
    sign_in_as_hello_world
    expect(page).not_to have_content("Welcome")
  end
end

describe "logging out" do

  it "doesn't show username on the homepage after logout" do
    sign_up_as_hello_world
    click_button "Sign Out"
    expect(page).not_to have_content("hello_world")
  end
end
