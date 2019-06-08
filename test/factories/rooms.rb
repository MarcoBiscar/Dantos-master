FactoryGirl.define do
  factory :room do
    user
    association :manager, factory: :user
    category_name { Faker::Lorem.word }
  end
end
