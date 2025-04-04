# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#

3.times do |i|
  User.create(
    email: "test_#{i+1}@test.com",
    password: 'password',
    points_balance: 100,
  )
end

5.times do |i|
  Reward.create(
    name: "Reward #{i+1}",
    description: "Description for Reward #{i+1}",
    price: rand(5) * 10,
  )
end

User.first.redeem!(Reward.first)
