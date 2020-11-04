class BookingStruct < ApplicationStruct
  attribute :user_id, Types::Integer
  attribute :wish_id, Types::Integer
  attribute :comment, Types::String.optional
  attribute :meta, Types::Hash.optional

  attribute? :user, Types::Hash
  attribute? :wish, Types::Hash
end
