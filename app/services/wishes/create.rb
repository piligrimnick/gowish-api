module Wishes
  class Create < ApplicationService
    option :user_id
    option :wish, {} do
      option :body
      option :url, optional: true
      option :picture, optional: true
    end

    def call
      wish_factory.create(wish.to_h.symbolize_keys)
    end

    private

    def wish_factory
      @wish_factory ||= WishFactory.new(gateway: ::Wish.where(user_id: user_id))
    end
  end
end
