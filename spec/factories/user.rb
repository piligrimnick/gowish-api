FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    telegram_id { Faker::Number.number(digits: 10) }
    firstname  { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
    password_confirmation { password }
  end
end
