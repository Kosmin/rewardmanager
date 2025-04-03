FactoryBot.define do
  factory :redemption do
    association :user
    association :reward
    data { nil }

    trait :with_user do
      after(:create) do |redemption|
        create(:user, redemptions: [ redemption ])
      end
    end

    trait :with_reward do
      after(:create) do |redemption|
        create(:reward, redemptions: [ redemption ])
      end
    end
  end
end
