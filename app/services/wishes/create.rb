module Wishes
  class Create < ApplicationService
    param :user
    option :wish, {} do
      option :body
      option :url, optional: true
    end

    def call
      wish_factory.create(wish.to_h.symbolize_keys)
    end

    private

    attr_reader :wish_factory

    def wish_factory
      @wish_factory ||= WishFactory.new(gateway: user.wishes)
    end
  end
end
