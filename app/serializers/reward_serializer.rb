class RewardSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :price, :description, :redemptions_count
end
