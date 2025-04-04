# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

     # Users
     field :users, [ Types::UserType ], null: false, description: "Returns all users"
     def users
       User.all
     end

     field :user, Types::UserType, null: true, description: "Returns a user by ID" do
       argument :id, ID, required: true
     end
     def user(id:)
       User.find_by(id: id)
     end

     # Rewards
     field :rewards, [ Types::RewardType ], null: false, description: "Returns all rewards"
     def rewards
       Reward.all
     end

     field :reward, Types::RewardType, null: true, description: "Returns a reward by ID" do
       argument :id, ID, required: true
     end
     def reward(id:)
       Reward.find_by(id: id)
     end

     # Redemptions
     field :redemptions, [ Types::RedemptionType ], null: false, description: "Returns all redemptions"
     def redemptions
       Redemption.all
     end

     field :redemption, Types::RedemptionType, null: true, description: "Returns a redemption by ID" do
       argument :id, ID, required: true
     end
     def redemption(id:)
       Redemption.find_by(id: id)
     end

    field :nodes, [ Types::NodeType, null: true ], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ ID ], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end
  end
end
