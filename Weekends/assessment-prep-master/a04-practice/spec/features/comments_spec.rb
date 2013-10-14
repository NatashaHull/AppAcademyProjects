require 'spec_helper'

feature "Adding comments to links" do
  before :each do
    sign_up_as_hello_world
  end

  it "there is an add comment form on the link show page" do
    make_link("google", "http://google.com")
    page.should have_content 'Add Comment'
  end

  it "shows the link show page on submit" do
    make_link("google", "http://google.com")
    fill_in 'Comment', with: 'yippy'
    click_button 'Add Comment'
    page.should have_content 'hello_world'
  end

  it "adds the comment to the comment list after clicking the submit button" do
    make_link("google", "http://google.com")
    fill_in 'Comment', with: 'yippy-chai-eh'
    click_button 'Add Comment'
    page.should have_content 'yippy-chai-eh'
  end
  
  it "validates presence of comment body" do
    make_link("google", "http://google.com")
    click_button 'Add Comment'
    page.should have_content "Content can't be blank"
  end
end

feature "Deleting comments" do
  before :each do
    sign_up_as_hello_world
    make_link("google", "http://google.com")
    fill_in 'Comment', with: "there are 10 kinds of people. Those who understand binary and those who dont."
    click_button "Add Comment"
  end

  it "displays a remove button next to each comment" do
    page.should have_button 'Remove Comment'
  end

  it "shows the link show page on click" do
    click_button 'Remove Comment'
    page.should have_content 'hello_world'
  end

  it "removes the comment on click" do
    click_button 'Remove Comment'
    page.should_not have_content 'there are 10 kinds of people. Those who understand binary and those who dont.'
  end
end
