require 'spec_helper'

feature "Sign up" do
  before :each do
    visit "/users/new"
  end

  it "has a user sign up page" do
    page.should have_content "Sign Up"
  end

  it "takes a username and password" do
    page.should have_content "Username"
    page.should have_content "Password"
  end
  
  it "validates the presence of the user's username" do
    click_button 'Sign Up'
    page.should have_content 'Sign Up'
    page.should have_content "Username can't be blank"
  end

  it "validates the presence of the user's password" do
    fill_in "Username", with: 'hello_world'
    click_button 'Sign Up'
    page.should have_content 'Sign Up'
    page.should have_content "Password can't be blank"
  end

  it "validates that the password is at least 6 characters long" do
    fill_in "Username", with: 'hello_world'
    fill_in "Password", with: 'short'
    click_button 'Sign Up'
    page.should have_content 'Sign Up'
    page.should have_content 'Password is too short'
  end

  it "logs the user in and redirects them to links index on success" do
    sign_up_as_hello_world
    # add user name to application.html.erb layout
    page.should have_content 'hello_world'
  end
end

feature "Sign out" do
  it "has a sign out button" do
    sign_up_as_hello_world
    page.should have_button 'Sign Out'
  end

  it "logs a user out on click and checks that its not allowed access to links index" do
    sign_up_as_hello_world

    click_button 'Sign Out'
    visit '/links'

    # redirect to login page
    page.should have_content 'Sign In'    
    page.should have_content "Username"
  end
end

feature "Sign in" do
  it "has a sign in page" do
    visit "/session/new"
    page.should have_content "Sign In"
  end

  it "takes a username and password" do
    visit "/session/new"
    page.should have_content "Username"
    page.should have_content "Password"
  end

  it "returns to sign in on failure" do
    visit "/session/new"
    fill_in "Username", with: 'hello_world'
    fill_in "Password", with: 'hello'
    click_button "Sign In"

    # return to sign-in page
    page.should have_content "Sign In"
    page.should have_content "Username"
  end

  it "takes a user to links index on success" do
    sign_up_as_hello_world
    # add button to sign out in application.html.erb layout
    click_button 'Sign Out'

    # Sign in as newly created user
    visit "/session/new"
    fill_in "Username", with: 'hello_world'
    fill_in "Password", with: 'abcdef'
    click_button "Sign In"
    page.should have_content "hello_world"
  end
end
