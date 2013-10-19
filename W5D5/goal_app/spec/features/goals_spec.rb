require 'spec_helper'

describe 'Goals' do
  describe 'creating goals' do
    before(:each) do
      sign_up_as_hello_world
      visit new_goal_url
    end

    it "creates a goal" do
      create_goal_hello_world
      expect(page).to have_content("Get fit")
    end
    it "requires a name" do
      fill_in "body", :with => "I want to run a mile everyday."
      click_on "Create Goal"
      expect(page).to have_content("Add New Goal")
    end
    it "requires a body" do
      fill_in "name", :with => "Get fit"
      click_on "Create Goal"
      expect(page).to have_content("Add New Goal")
    end
    it "requires a current user" do
      click_on "Sign Out"
      visit new_goal_url
      expect(page).to have_content("Sign In")
    end
    it "belongs to the current user" do
      create_goal_hello_world
      visit goal_url(1)
      expect(page).to have_content("hello_world")
    end
  end

  describe 'editing goals' do
    before(:each) do
      Goal.delete_all
      sign_up_as_hello_world
      create_goal_hello_world
      visit edit_goal_url(1)
    end

    it "edits the goal" do
      fill_in "name", :with => "Get fat"
      fill_in "body", :with => "Eat a pound of ice cream everyday"
      click_on "Update"
      expect(page).to have_content("Get fat")
    end
    it "requires a name" do
      fill_in "name", :with => ""
      fill_in "body", :with => "Eat a pound of ice cream everyday"
      click_on "Update"
      expect(page).to have_content("Edit Goal")
    end
    it "requires a body" do
      fill_in "name", :with => "Get fat"
      fill_in "body", :with => ""
      click_on "Update"
      expect(page).to have_content("Edit Goal")
    end
    it "requires a current user" do
      click_on "Sign Out"
      visit edit_goal_url(1)
      expect(page).to have_content("Sign In")
    end
    it "belongs to the current user" do
      click_on "Sign Out"
      sign_up("hello_moon")
      visit edit_goal_url(1)
      expect(page).to have_content("Get fit")
    end
  end

  describe 'showing goals' do
    before(:each) do
      Goal.delete_all
      sign_up_as_hello_world
      create_goal_hello_world
      visit goal_url(1)
    end

    it "shows the goal name" do
      expect(page).to have_content("Get fit")
    end

    it "shows the goal body" do
      expect(page).to have_content("I want to run a mile everyday.")
    end
    it "shows the goal's owner" do
      expect(page).to have_content("hello_world")
    end
    it "only shows a delete button to the goal's owner" do
      click_on "Sign Out"
      sign_up("hello_moon")
      visit goal_url(1)
      expect(page).not_to have_content("Remove Goal")
    end
  end

  describe 'removing goals' do
    it "should remove the goal" do
      Goal.delete_all
      sign_up_as_hello_world
      create_goal_hello_world
      visit goals_url
      click_on "Get fit"
      click_on "Remove Goal"
      expect(page).not_to have_content("Get fit")
    end
  end
end