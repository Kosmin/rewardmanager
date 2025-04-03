# spec/models/reward_spec.rb
require 'rails_helper'

RSpec.describe Reward, type: :model do
  let(:reward) { create(:reward) }

  # Association tests
  describe 'associations' do
    describe 'has_many :redemptions' do
      it 'has many redemptions' do
        redemption1 = create(:redemption, reward: reward)
        redemption2 = create(:redemption, reward: reward)
        expect(reward.redemptions).to include(redemption1, redemption2)
      end

      it 'nullifies redemptions when destroyed' do
        redemption = create(:redemption, reward: reward)
        reward.destroy
        expect(redemption.reload.reward_id).to be_nil
      end

      it 'sets inverse_of to reward' do
        redemption = create(:redemption, reward: reward)
        expect(redemption.reward).to eq(reward)
      end
    end

    describe 'has_many :users, through: :redemptions' do
      it 'has many users through redemptions' do
        user1 = create(:user)
        user2 = create(:user)
        create(:redemption, reward: reward, user: user1)
        create(:redemption, reward: reward, user: user2)
        expect(reward.users).to include(user1, user2)
      end
    end
  end

  # Validation tests
  describe 'validations' do
    describe 'name presence' do
      it 'is invalid without a name' do
        reward = build(:reward, name: nil)
        expect(reward).not_to be_valid
        expect(reward.errors[:name]).to include("can't be blank")
      end

      it 'is valid with a name' do
        reward = build(:reward, name: 'Test Reward')
        expect(reward).to be_valid
      end
    end

    describe 'name uniqueness' do
      it 'is invalid with a duplicate name' do
        create(:reward, name: 'Unique Reward')
        duplicate_reward = build(:reward, name: 'Unique Reward')
        expect(duplicate_reward).not_to be_valid
        expect(duplicate_reward.errors[:name]).to include('has already been taken')
      end

      it 'is valid with a unique name' do
        create(:reward, name: 'Reward 1')
        reward = build(:reward, name: 'Reward 2')
        expect(reward).to be_valid
      end
    end

    describe 'price numericality' do
      it 'is invalid with a negative price' do
        reward = build(:reward, price: -1.0)
        expect(reward).not_to be_valid
        expect(reward.errors[:price]).to include('must be greater than or equal to 0.0')
      end

      it 'is valid with a price of 0.0' do
        reward = build(:reward, price: 0.0)
        expect(reward).to be_valid
      end

      it 'is valid with a positive price' do
        reward = build(:reward, price: 10.0)
        expect(reward).to be_valid
      end

      it 'is invalid with a non-numeric price' do
        reward = build(:reward, price: 'not_a_number')
        expect(reward).not_to be_valid
        expect(reward.errors[:price]).to include('is not a number')
      end
    end
  end
end
