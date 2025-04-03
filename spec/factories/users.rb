FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
    points_balance { 0 }
    admin { false }
    redemptions_count { 0 }
    rewards_count { 0 }
  end
end
