require 'spec_helper'

describe User do
  it "should have a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end

  it "must have email" do
    FactoryGirl.build(:user, :email => "").should_not be_valid
  end

  it "must have unique email" do
    FactoryGirl.create(:user, :email => "Foo")
    FactoryGirl.build(:user, :email => "Foo").should_not be_valid
  end

  describe '#password' do
    it "must have password on create" do
      FactoryGirl.build(:user, :password => " ").should_not be_valid
    end

    it "cannot be blank" do
      FactoryGirl.build(:user, :password => "  ").should_not be_valid
    end
    it "must be at least 6 characters" do
      FactoryGirl.build(:user, :password => "ma").should_not be_valid
    end

    it "can be nil" do
      FactoryGirl.build(:user, :password => nil).should be_valid
    end
  end

  context "created user" do
    subject!(:user) { FactoryGirl.create(:user, :email => "Foo", :password => "Amazing") }

    its(:password_digest) { should_not be_nil }

    it "must not store password" do
      User.find(user.id).password.should be_nil
    end

    describe '#find_by_credentials' do
      it "finds the correct user" do
        found_user = User.find_by_credentials({email:"Foo", password:"Amazing"})
        found_user.should_not be_nil
        found_user.id.should == user.id
      end

      it "does not find user with wrong password" do
        found_user = User.find_by_credentials({email:"Foo", password:"NotAmazing"})
        found_user.should be_nil
      end
    end

    describe "#associations" do
      it { should have_many(:links) }
      it { should have_many(:subs) }
      it { should have_many(:comments) }

      it "links must be the right type" do
        FactoryGirl.create(:link, :author => user)
        user.links.first.should be_a(Link)
      end

      it "subs must be the right type" do
        FactoryGirl.create(:sub, :moderator => user)
        user.subs.first.should be_a(Sub)
      end

      it "comments must be the right type" do
        FactoryGirl.create(:comment, :author => user)
        user.comments.first.should be_a(Comment)
      end
    end
  end
end
