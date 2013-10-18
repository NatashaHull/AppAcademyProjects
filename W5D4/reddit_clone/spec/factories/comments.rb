# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    sequence :author do
      FactoryGirl.create(:user)
    end
    sequence :link do
      FactoryGirl.create(:link)
    end
    content { Faker::Lorem.paragraph }
  end
end
