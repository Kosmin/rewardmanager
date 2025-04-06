class RedemptionSerializer
  include JSONAPI::Serializer
  attributes :id, :user_id, :reward_id, :created_at, :updated_at, :data
  attribute :reward do |object|
    object.reward.as_json(only: [ :id, :name, :description, :price ])
  end
end
