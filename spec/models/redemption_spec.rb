# spec/models/redemption_spec.rb
require 'rails_helper'

RSpec.describe Redemption, type: :model do
  let(:user) { create(:user) }
  let(:reward) { create(:reward) }
  let(:redemption) { create(:redemption, user: user, reward: reward) }

  describe 'associations' do
    describe 'belongs_to :user' do
      it 'belongs to a user' do
        expect(redemption.user).to eq(user)
      end

      it 'increments user.redemptions_count' do
        expect { create(:redemption, user: user, reward: reward) }
          .to change { user.reload.redemptions_count }.from(0).to(1)
      end

      it 'sets inverse_of to redemptions' do
        expect(user.redemptions).to include(redemption)
      end
    end

    describe 'belongs_to :reward' do
      it 'belongs to a reward' do
        expect(redemption.reward).to eq(reward)
      end

      it 'increments reward.redemptions_count' do
        expect { create(:redemption, user: user, reward: reward) }
          .to change { reward.reload.redemptions_count }.from(0).to(1)
      end

      it 'sets inverse_of to redemptions' do
        expect(reward.redemptions).to include(redemption)
      end
    end
  end

  describe 'validations' do
    describe 'presence of user' do
      it 'is invalid without a user' do
        redemption = build(:redemption, user: nil, reward: reward)
        expect(redemption).not_to be_valid
        expect(redemption.errors[:user]).to include("can't be blank")
      end

      it 'is valid with a user' do
        redemption = build(:redemption, user: user, reward: reward)
        expect(redemption).to be_valid
      end
    end

    describe 'uniqueness of user_id scoped to reward_id' do
      it 'is invalid with duplicate user_id and reward_id' do
        create(:redemption, user: user, reward: reward)
        duplicate = build(:redemption, user: user, reward: reward)
        expect(duplicate).not_to be_valid
        expect(duplicate.errors[:user_id]).to include('has already been taken')
      end

      it 'is valid with same user_id and different reward_id' do
        another_reward = create(:reward, name: 'Another Reward')
        create(:redemption, user: user, reward: reward)
        new_redemption = build(:redemption, user: user, reward: another_reward)
        expect(new_redemption).to be_valid
      end

      it 'allows nil user_id despite uniqueness' do
        redemption = build(:redemption, user: nil, reward: reward)
        expect(redemption.errors[:user_id]).not_to include('has already been taken')
      end
    end
  end

  describe 'callbacks' do
    describe 'before_commit :validate_reward_presence, on: :create' do
      it 'prevents creation and adds error if reward is not present' do
        redemption = build(:redemption, user: user, reward: nil)
        expect(redemption.save).to be_falsey
        expect(redemption.errors[:reward]).to include('must exist')
      end

      it 'allows creation if reward is present' do
        redemption = build(:redemption, user: user, reward: reward)
        expect(redemption.save!).to be_truthy
      end
    end

    describe 'before_commit :cache_reward_data!, on: :create' do
      it 'caches reward data on create' do
        redemption = build(:redemption, user: user, reward: reward)
        expect(redemption.data).to be_nil
        redemption.save!
        expect(redemption.data).to eq(reward.to_json)
      end
    end

    describe 'before_commit :validate_reward_presence, on: :create' do
      let(:user) { create(:user) }
      it 'aborts if reward is blank' do
        expect(user.redeem!(nil)).to be_nil
        expect(user.errors.full_messages).to include("Cannot redeem reward: reward is blank")
      end
    end
  end
end
