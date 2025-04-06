require 'rails_helper'

RSpec.describe RewardsController, type: :controller do
  describe 'GET #index' do
    let(:user) { create(:user) }
    let!(:reward1) { create(:reward, name: 'Reward 1', created_at: 2.days.ago) }
    let!(:reward2) { create(:reward, name: 'Reward 2', created_at: 1.day.ago) }
    let!(:redemption) { create(:redemption, reward: reward1, user: user) }

    it 'returns all rewards ordered by created_at descending' do
      get :index
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['data'].map { |r| r['attributes']['name'] }).to eq([ 'Reward 2', 'Reward 1' ])
      expect(json_response['data'].first['attributes']['redemptions_count']).to eq(0)
      expect(json_response['data'].last['attributes']['redemptions_count']).to eq(1)
    end
  end
end
