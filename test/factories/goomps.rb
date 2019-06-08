FactoryGirl.define do
  factory :goomp do
    name { Faker::Commerce.product_name }
    cover { "http://lorempixel.com/1500/300/" }
    description { Faker::Lorem.paragraph }
    user
  end
end
