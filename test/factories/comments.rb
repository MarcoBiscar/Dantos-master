FactoryGirl.define do
  factory :comment do
    body { Faker::Lorem.sentence }
    post
    user
  end
end
