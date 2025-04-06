# app/graphql/types/reward_type.rb
module Types
  class RewardType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: false
    field :price, Float, null: false
    field :redemptions_count, Integer, null: false
    field :redemptions, [ Types::RedemptionType ], null: true
  end
end
