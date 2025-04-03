class Reward < ApplicationRecord
  has_many :redemptions, dependent: :nullify, inverse_of: :reward
  has_many :users, through: :redemptions

  validates_presence_of :name
  validates :name, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0.0 }
  validates :expires_at, date: { allow_blank: true }
end
