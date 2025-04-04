class Redemption < ApplicationRecord
  belongs_to :user, counter_cache: true, inverse_of: :redemptions
  belongs_to :reward, counter_cache: true, inverse_of: :redemptions

  validates_presence_of :user
  validates :user_id, uniqueness: { scope: :reward_id, allow_nil: true }

  before_commit :validate_reward_presence, on: :create
  after_create :cache_reward_data!

  private

  def validate_reward_presence
    if reward.blank?
      errors.add(:reward, "must exist")
      throw :abort
    end
  end

  # Cache reward data in JSON format, to allow retrieving it if the Reward is deleted
  def cache_reward_data!
    self.update!(data: reward.to_json)
  end
end
