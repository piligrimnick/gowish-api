class WishesRepository < ApplicationRepository
  def initialize(gateway: Wish, collection: WishesCollection, struct: WishStruct)
    super
  end

  def filter(params, order: 'created_at desc')
    @objects = gateway.order(order).where(params)

    structurize
  end
end
