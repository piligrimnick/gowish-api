module Wishes
  class Realise < ApplicationService
    option :wish_id

    def call
      wish_factory.realise(wish_id)
      # update_statistic
      # send_email
    end

    private

    def wish_factory
      @wish_factory ||= FactoryRegistry.for(:wish)
    end
  end
end
