FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    headline { Faker::Lorem.word }
    picture { "http://lorempixel.com/200/200/cats/" }
    password "qwer1234"
    password_confirmation "qwer1234"
  end
end
