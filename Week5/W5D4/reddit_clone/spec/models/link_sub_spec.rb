require 'spec_helper'

describe LinkSub do
  it "creates a valid factory" do
    FactoryGirl.create(:link_sub).should be_valid
  end

  it "should have a valid sub_id" do
    FactoryGirl.build(:link_sub, :sub_id => " ").should_not be_valid
  end

  it "should have a valid link_id" do
    FactoryGirl.build(:link_sub, :link_id => " ").should_not be_valid
  end

  describe '#associations' do
    subject(:link_sub) { FactoryGirl.create(:link_sub) }

    it { should belong_to(:link) }
    it { should belong_to(:sub) }

    it "sub should be the right type" do
      link_sub.sub.should be_a(Sub)
    end

    it "link should be the right type" do
      link_sub.link.should be_a(Link)
    end

  end
end
