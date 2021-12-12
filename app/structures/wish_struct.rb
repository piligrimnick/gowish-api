class WishStruct < ApplicationStruct
  attribute :body, Types::String.optional
  attribute :url, Types::String.optional
  attribute :user_id, Types::Integer
  attribute :state, Types::String
  attribute :created_at, Types::Time

  attribute? :user, Types::Hash
  attribute? :booking, Types::Hash
  attribute? :booker, Types::Hash
  attribute? :picture_url, Types::String
end
