# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  # Association tests
  describe 'associations' do
    it { should have_many(:redemptions).dependent(:destroy).inverse_of(:user) }
    it { should have_many(:rewards).through(:redemptions) }
  end
end
