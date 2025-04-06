# app/graphql/types/user_type.rb
module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :points_balance, Integer, null: false
    field :redemptions_count, Integer, null: false
    field :redemptions, [ Types::RedemptionType ], null: true
  end
end
