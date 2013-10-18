require 'spec_helper'

describe Link do
  it "should have a valid factory" do
    FactoryGirl.create(:link).should be_valid
  end

  it "should have an author" do
    FactoryGirl.build(:link, :author => nil).should_not be_valid
  end
  it "should have a url" do
    FactoryGirl.build(:link, :url => "").should_not be_valid
  end
  it "should have a title" do
    FactoryGirl.build(:link, :title => "  ").should_not be_valid
  end

  it "may have a description" do
    FactoryGirl.build(:link, :description => "").should be_valid
    FactoryGirl.build(:link, :description => "lad of land").should be_valid
  end

  describe "associations" do
    subject(:link) { FactoryGirl.create(:link) }

    it { should have_many(:link_subs) }
    it { should have_many(:subs).through(:link_subs) }
    it { should belong_to(:author) }
    it { should have_many(:comments) }

    it "must have the right kind of linksubs" do
      FactoryGirl.create(:link_sub, :link => link)
      link.link_subs.first.should be_a(LinkSub)
    end

    it "must have the right kind of subs" do
      FactoryGirl.create(:sub, :link_ids => [link.id])
      link.subs.first.should be_a(Sub)
    end

    it "must have the right kind of author" do
      link.author.should be_a(User)
    end

    it "must have the right kind of comment" do
      FactoryGirl.create(:comment, :link => link)
      link.comments.first.should be_a(Comment)
    end
  end
end
