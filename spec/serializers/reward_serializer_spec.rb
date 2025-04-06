require 'rails_helper'

RSpec.describe RewardSerializer do
  let(:user) { create(:user) }
  let(:reward) { create(:reward, name: 'Test Reward', price: 100, description: 'A reward') }
  let(:serializer) { RewardSerializer.new(reward) }
  let(:serialization) { JSON.parse(serializer.serializable_hash.to_json) }

  describe 'attributes' do
    it 'includes basic attributes' do
      create(:redemption, user: user, reward: reward)
      reward.reload
      expect(serialization['data']['attributes']).to include(
        'name' => 'Test Reward',
        'price' => reward.price,
        'description' => 'A reward',
        'redemptions_count' => 1
      )
    end
  end
end
