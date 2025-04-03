class Redemption < ApplicationRecord
  belongs_to :user, counter_cache: true, inverse_of: :redemptions
  belongs_to :reward, counter_cache: true, inverse_of: :redemptions

  validates_presence_of :user
  validates :user_id, uniqueness: { scope: :reward_id, allow_nil: true }

  before_commit :cache_reward_data!, on: :create

  private

  # Cache reward data in JSON format, to allow retrieving it if the Reward is deleted
  def cache_reward_data!
    if reward.blank?
      errors.add(:reward, "must exist")
      false
    else
      self.data = reward.to_json if reward.present?
    end
  end
end
