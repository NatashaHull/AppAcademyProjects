# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    url {Faker::Internet.url}
    title "My Title"
    description {Faker::Lorem.sentence}
    sequence :author do |n|
      FactoryGirl.create(:user)
    end
  end
end
