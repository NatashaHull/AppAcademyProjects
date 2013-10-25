# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "MyString"
    password_digest "MyString"
    session_token "MyString"
  end
end
