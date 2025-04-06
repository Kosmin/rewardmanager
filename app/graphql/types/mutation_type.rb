module Types
  class MutationType < Types::BaseObject
    # Reward Mutations
    field :create_reward, Types::RewardType, null: true, description: "Creates a reward" do
      argument :name, String, required: true
      argument :price, Float, required: true
      argument :description, String, required: false
    end

    def create_reward(name:, price:, description: nil)
      Reward.create(name: name, price: price, description: description)
    end

    field :update_reward, Types::RewardType, null: true, description: "Updates a reward" do
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :price, Float, required: false
      argument :description, String, required: false
    end

    def update_reward(id:, name: nil, price: nil, description: nil)
      reward = Reward.find(id)
      reward.update(
        name: name || reward.name,
        price: price || reward.price,
        description: description || reward.description
      )
      reward
    end

    # Redemption Mutations
    field :create_redemption, Types::RedemptionType, null: true, description: "Creates a redemption" do
      argument :user_id, ID, required: true
      argument :reward_id, ID, required: true
    end

    def create_redemption(user_id:, reward_id:)
      Redemption.create(user_id: user_id, reward_id: reward_id)
    end

    # User Mutations
    field :create_user, Types::UserType, null: true, description: "Creates a user" do
      argument :email, String, required: true
      argument :password, String, required: true
      argument :points_balance, Integer, required: false
    end

    def create_user(email:, password:, points_balance: 0)
      User.create(email: email, password: password, points_balance: points_balance)
    end

    field :update_user, Types::UserType, null: true, description: "Updates a user" do
      argument :id, ID, required: true
      argument :email, String, required: false
      argument :password, String, required: false
      argument :points_balance, Integer, required: false
    end

    def update_user(id:, email: nil, password: nil, points_balance: nil)
      user = User.find(id)
      user.update(
        email: email || user.email,
        password: password || user.password,
        points_balance: points_balance.nil? ? user.points_balance : points_balance
      )
      user
    end
  end
end
