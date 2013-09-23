require 'spec_helper'

feature "Can move from link index to new" do
  context "when logged in" do
    before :each do 
      sign_up_as_hello_world
      visit '/links'
    end
    
    it "link index has a 'New Link' link to new link page" do
      page.should have_content "New Link"
    end
  end
end

feature "Creating a link" do
  context "when logged in" do
    before :each do
      sign_up_as_hello_world
      visit '/links/new'
    end

    it "has a new link page" do
      page.should have_content 'New Link'
    end

    it "takes a title and a url" do
      page.should have_content 'Title'
      page.should have_content 'URL'
    end

    it "validates the presence of title" do
      fill_in 'URL', with: 'http://google.com'
      click_button 'Create New Link'
      page.should have_content 'New Link'
      page.should have_content "Title can't be blank"
    end

    it "validates the presence of url" do
      fill_in 'Title', with: 'google'
      click_button 'Create New Link'
      page.should have_content 'New Link'
      page.should have_content "Url can't be blank"
    end

    it "redirects to the link show page" do
      fill_in 'URL', with: 'http://google.com'
      fill_in 'Title', with: 'google'
      click_button 'Create New Link'
      page.should have_content 'google'
    end

    context "on failed save" do
      before :each do
        fill_in 'Title', with: 'google'
      end

      it "displays the new link form again" do
        page.should have_content 'New Link'
      end

      it "has a pre-filled form (with the data previously input)" do
        find_field('Title').value.should eq 'google'
      end

      it "still allows for a successful save" do
        fill_in 'URL', with: 'http://google.com'
        click_button 'Create New Link'
        page.should have_content 'google'
      end
    end
  end

  context "when logged out" do
    it "redirects to the login page" do
      visit '/links/new'
      page.should have_content 'Sign In'
    end
  end
end

feature "Seeing all links" do
  context "when logged in" do
    before :each do
      sign_up_as_hello_world
      make_link("google", "http://google.com")
      make_link("amazon", "http://amazon.com")
      visit '/links'
    end

    it "shows all the posts for the current user" do
      page.should have_content 'google'
      page.should have_content 'amazon'
    end

    it "shows the current user's username" do
      page.should have_content 'hello_world'
    end

    it "links to each of the link *show* pages with the link titles next" do
      click_link 'google'
      page.should have_content 'google'
      page.should_not have_content 'amazon'
    end
  end

  context "when logged out" do
    it "redirects to the login page" do
      visit '/links'
      page.should have_content 'Sign In'
    end
  end

  context "when signed in as another user" do
    before :each do
      sign_up('hello_world')
      click_button 'Sign Out'
      sign_up('goodbye_world')
      make_link("facebook", "http://facebook.com")
      click_button 'Sign Out'
      sign_in('hello_world')
    end

    it "should show others links" do
      visit '/links'
      page.should have_content 'facebook'
    end
  end
end

feature "Showing a link" do
  context "when logged in" do
    before :each do
      sign_up('hello_world')
      make_link("google", "http://google.com")
      visit '/links'
      click_link 'google'
    end

    it "displays the link title" do
      page.should have_content 'google'
    end

    it "displays the link url" do
      page.should have_content 'http://google.com'
    end
    
    it "displays a link back to the link index" do
      page.should have_content "Links"
    end
  end
end

feature "Editing a link" do
  before :each do
    sign_up_as_hello_world
    make_link("google", "http://google.com")
    visit '/links'
    click_link 'google'
  end

  it "has a link on the show page to edit a link" do
    page.should have_content 'Edit Link'
  end

  it "shows a form to edit the link" do
    click_link 'Edit Link'
    page.should have_content 'Title'
    page.should have_content 'URL'
  end

  it "has all the data pre-filled" do
    click_link 'Edit Link'
    find_field('Title').value.should eq 'google'
    find_field('URL').value.should eq 'http://google.com'
  end
  
  it "shows errors if editing fails" do
    click_link 'Edit Link'
    fill_in 'URL', with: ''
    click_button 'Update Link'
    page.should have_content "Edit Link"
    page.should have_content "Url can't be blank"
  end

  context "on successful update" do
    before :each do
      click_link 'Edit Link'
    end

    it "redirects to the link show page" do
      fill_in 'Title', with: 'DuckDuckGo'
      click_button 'Update Link'
      page.should have_content 'DuckDuckGo'
    end
  end
end
