class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  has_many :redemptions, dependent: :destroy, inverse_of: :user
  has_many :rewards, through: :redemptions

  def can_redeem?(reward)
    self.points_balance >= reward.price && !self.rewards.include?(reward)
  end

  # Redeems a reward by creating a redemption & decreasing the user's points
  #   * to prevent concurrency issues, with multiple threads attempting to redeem a reward
  #     without sufficient points we need to lock the user row and ensure the user has sufficient points
  #   * concurrency-issues related to having multiple redemptions is enforced at the DB-level
  #     by unique constraint on reward_id and user_id which ensures the reward was not previously redeemed
  # @return <Redemption> the created redemption record
  def redeem!(reward)
    unless reward.present?
      errors.add(:base, "Cannot redeem reward: reward is blank")
      return nil
    end

    unless can_redeem?(reward)
      errors.add(:base, "Cannot redeem reward: insufficient points or already redeemed")
      return nil
    end

    ActiveRecord::Base.transaction do
      self.lock!
      self.points_balance -= reward.price
      self.save!
      self.redemptions.create!(reward: reward)
    end
  end
end

# Plan: 1) allow redemptions; 2) create UI; 3) connect front-end to back-end; 4) seed data and test app
