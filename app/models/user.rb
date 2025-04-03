class User < ApplicationRecord
  has_many :redemptions, dependent: :destroy, inverse_of: :user
  has_many :rewards, through: :redemptions
end
