# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link_sub do
    sequence :link do |n|
      FactoryGirl.create(:link)
    end
    sequence :sub do |n|
      FactoryGirl.create(:sub)
    end
  end
end
