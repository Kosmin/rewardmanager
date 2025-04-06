require 'rails_helper'

RSpec.describe RedemptionsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user, email: 'test@example.com', points_balance: 500) }
  let(:reward) { create(:reward, name: 'Test Reward', price: 100) }
  let(:jwt_token) { Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first }

  describe 'GET #index' do
    let!(:redemption) { create(:redemption, user: user, reward: reward) }

    before do
      request.headers['Authorization'] = "Bearer #{jwt_token}"
      get :index
    end

    it 'returns the user’s redemptions with rewards included' do
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['data'].first['attributes']).to include(
        'user_id' => user.id,
        'reward_id' => reward.id,
        'data' => redemption.data
      )
      expect(json_response['data'].first['attributes']['reward']).to include(
        'id' => reward.id,
        'name' => 'Test Reward',
        'price' => 100
      )
    end
  end

  describe 'POST #create' do
    context 'with valid reward and sufficient balance' do
      before do
        request.headers['Authorization'] = "Bearer #{jwt_token}"
        Redemption.where(user: user, reward: reward).destroy_all
        post :create, params: { reward_id: reward.id }
      end

      it 'creates a redemption and returns it' do
        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response['data']['attributes']).to include(
          'user_id' => user.id,
          'reward_id' => reward.id
        )
      end
    end

    context 'with missing reward' do
      before do
        request.headers['Authorization'] = "Bearer #{jwt_token}"
        post :create, params: { reward_id: 999 }
      end

      it 'returns not found' do
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq('errors' => [ 'Reward not found' ])
      end
    end

    context 'with insufficient balance' do
      before do
        user.update(points_balance: 50)
        request.headers['Authorization'] = "Bearer #{jwt_token}"
        post :create, params: { reward_id: reward.id }
      end

      it 'returns unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq('errors' => [ 'Cannot redeem reward: insufficient points or already redeemed' ])
      end
    end

    context 'with redemption errors' do
      let!(:redemption) { create(:redemption, user: user, reward: reward) }
      before do
        request.headers['Authorization'] = "Bearer #{jwt_token}"
        post :create, params: { reward_id: reward.id }
      end

      it 'returns unprocessable entity with errors' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq('errors' => [ 'Cannot redeem reward: insufficient points or already redeemed' ])
      end
    end
  end
end
