class WishStruct < ApplicationStruct
  attribute :body, Types::String.optional
  attribute :url, Types::String.optional
  attribute :user_id, Types::Integer
  attribute :created_at, Types::Time
end
