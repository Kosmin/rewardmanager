class RewardSerializer
  include JSONAPI::Serializer
  attributes :name, :price, :description, :redemptions_count
end
