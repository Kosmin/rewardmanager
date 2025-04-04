# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, points_balance: 10) }
  let(:reward) { create(:reward, price: 10) }

  # Association tests
  describe 'associations' do
    it { should have_many(:redemptions).dependent(:destroy).inverse_of(:user) }
    it { should have_many(:rewards).through(:redemptions) }
  end

  describe '#can_redeem?' do
    context 'when user has enough points and has not redeemed the reward' do
      it 'redeems the reward' do
        expect(user.can_redeem?(reward)).to be true
      end
    end

    context 'when not enough points' do
      let(:user) { create(:user, points_balance: 5) }
      it 'does not redeem reward' do
        expect(user.can_redeem?(reward)).to be false
      end
    end

    context 'when reward already redeemed' do
      let!(:redemption) { create(:redemption, user: user, reward: reward) }
      it 'does not redeem reward' do
        expect(user.can_redeem?(reward)).to be false
      end
    end
  end

  describe '#redeem!' do
    context 'when reward is nil' do
      it 'does not redeem reward' do
        expect(user.redeem!(nil)).to be_nil
        expect(user.errors[:base]).to include("Cannot redeem reward: reward is blank")
      end
    end

    context 'when can_redeem? is false' do
      it 'does not redeem reward' do
        allow_any_instance_of(User).to receive(:can_redeem?).and_return(false)
        expect(user.redeem!(reward)).to be_nil
        expect(user.errors[:base]).to include("Cannot redeem reward: insufficient points or already redeemed")
      end
    end

    context 'when can_redeem? is true' do
      it 'redeems the reward' do
        expect { user.redeem!(reward) }.to change { user.points_balance }.by(-reward.price)
        expect(user.redemptions.count).to eq(1)
        expect(user.redemptions.first.reward).to eq(reward)
      end
    end
  end
end
