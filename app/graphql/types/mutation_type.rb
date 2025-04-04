# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # app/graphql/types/mutation_type.rb

    # Reward Mutations
    field :create_reward, Types::RewardType, null: true, description: "Creates a reward" do
      argument :name, String, required: true
      argument :price, Float, required: true
      argument :description, String, required: false
    end

    def create_reward(name:, price:)
      Reward.create(name: name, price: price)
    end

    # Redemption Mutations
    field :create_redemption, Types::RedemptionType, null: true, description: "Creates a redemption" do
      argument :user_id, ID, required: true
      argument :reward_id, ID, required: true
    end

    def create_redemption(user_id:, reward_id:)
      Redemption.create(user_id: user_id, reward_id: reward_id)
    end
  end
end
