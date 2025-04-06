require 'rails_helper'

RSpec.describe UserSerializer do
  let(:user) { create(:user, email: 'test@example.com', points_balance: 500) }
  let(:serializer) { UserSerializer.new(user) }
  let(:serialization) { JSON.parse(serializer.serializable_hash.to_json) }

  describe 'attributes' do
    it 'includes basic attributes' do
      reward = create(:reward)
      create(:redemption, user: user, reward: reward)
      user.reload
      expect(serialization['data']['attributes']).to include(
        'email' => 'test@example.com',
        'points_balance' => 500,
        'redemptions_count' => 1
      )
    end
  end
end
