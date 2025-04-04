# app/graphql/types/redemption_type.rb
module Types
  class RedemptionType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, ID, null: false
    field :reward_id, ID, null: true
    field :user, Types::UserType, null: false
    field :reward, Types::RewardType, null: true
    field :data, String, null: true # Assuming this is a JSON string
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
