# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sub do
    name {Faker::Name.name}
    sequence :moderator do |n|
      FactoryGirl.create(:user)
    end
  end
end
