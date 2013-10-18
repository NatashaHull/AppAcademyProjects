# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence :email do |e|
      Faker::Internet.email
    end
    password "MyString"
  end
end
