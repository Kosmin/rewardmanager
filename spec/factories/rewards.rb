FactoryBot.define do
  factory :reward do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    price { Faker::Number.decimal(l_digits: 2) }
    expires_at { Faker::Date.forward(days: 30) }
    redemptions_count { 0 }
    users_count { 0 }
  end
end
