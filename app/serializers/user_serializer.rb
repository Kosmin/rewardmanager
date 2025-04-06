class UserSerializer
  include JSONAPI::Serializer
  attributes :email, :points_balance, :redemptions_count
end
