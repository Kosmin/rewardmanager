require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user, email: 'test@example.com', points_balance: 500) }
  let(:jwt_token) { Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first }

  describe 'GET #show' do
    context 'with a signed-in user' do
      before do
        request.headers['Authorization'] = "Bearer #{jwt_token}"
        get :show
      end

      it 'returns the current user details' do
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['data']['attributes']).to include(
          'email' => 'test@example.com',
          'points_balance' => 500,
          'redemptions_count' => 0
        )
      end
    end

    context 'without a signed-in user' do
      before do
        get :show
      end

      it 'returns unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
