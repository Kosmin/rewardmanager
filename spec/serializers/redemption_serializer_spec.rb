require 'rails_helper'

RSpec.describe RedemptionSerializer do
  let(:user) { create(:user) }
  let(:reward) { create(:reward, name: 'Test Reward', description: 'A reward', price: 100) }
  let(:redemption) { create(:redemption, user: user, reward: reward) }
  let(:serializer) { RedemptionSerializer.new(redemption) }
  let(:serialization) { JSON.parse(serializer.serializable_hash.to_json) }

  describe 'attributes' do
    it 'includes basic attributes' do
      expect(serialization['data']['attributes']).to include(
        'id' => redemption.id,
        'user_id' => user.id,
        'reward_id' => reward.id,
        'data' => redemption.data,
      )
      expect(serialization['data']['attributes']['created_at']).to be_present
      expect(serialization['data']['attributes']['updated_at']).to be_present
    end

    it 'includes reward attribute' do
      expect(serialization['data']['attributes']['reward']).to eq(
        'id' => reward.id,
        'name' => 'Test Reward',
        'description' => 'A reward',
        'price' => 100
      )
    end
  end
end
