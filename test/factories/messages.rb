FactoryGirl.define do
  factory :message do
    body "MyString"
    room
    user
  end
end
