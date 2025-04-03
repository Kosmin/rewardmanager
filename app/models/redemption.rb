class Redemption < ApplicationRecord
  belongs_to :user, counter_cache: true, inverse_of: :redemptions
  belongs_to :reward, counter_cache: true, inverse_of: :redemptions

  validates_presence_of :user
  validates :user_id, uniqueness: { scope: :reward_id, allow_nil: true }
end
