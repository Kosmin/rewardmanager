class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :points_balance, :redemptions_count
end
