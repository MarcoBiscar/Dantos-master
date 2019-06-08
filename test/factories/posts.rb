FactoryGirl.define do
  factory :post do
    body { Faker::Lorem.paragraph }
    link_title { Faker::Lorem.sentence }
    link_image { "http://lorempixel.com/620/200/" }
    link_url { Faker::Internet.url }
    goomp
    user
  end
end
