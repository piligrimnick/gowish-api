FactoryBot.define do
  factory :wish do
    body { Faker::Lorem.sentence }
    url { Faker::Internet.url }
    user
  end
end
