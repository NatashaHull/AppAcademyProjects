require 'spec_helper'

describe Sub do

  it "should have a valid factory" do
    FactoryGirl.create(:sub).should be_valid
  end

  it "should have a moderator_id" do
    FactoryGirl.build(:sub, :moderator_id => "").should_not be_valid
  end
  it "should have a name" do
    FactoryGirl.build(:sub, :name => "").should_not be_valid
  end

  describe '#associations' do
    subject(:sub) {FactoryGirl.create(:sub)}

    it { should belong_to(:moderator) }
    it { should have_many(:link_subs) }
    it { should have_many(:links).through(:link_subs) }

    it "should return a user" do
      sub.moderator.should be_a(User)
    end
    it "should return a link_sub" do
      FactoryGirl.create(:link_sub, :sub => sub)
      sub.link_subs.first.should be_a(LinkSub)
    end
    it "should return a link" do
      FactoryGirl.create(:link, :sub_ids => [sub.id])
      sub.links.first.should be_a(Link)
    end
  end
end
