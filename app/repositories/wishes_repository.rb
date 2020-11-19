class WishesRepository < ApplicationRepository
  def initialize(gateway: Wish, collection: WishesCollection, struct: WishStruct)
    super
  end

  def filter(params)
    @objects = gateway.order(:created_at).where(params)

    structurize
  end
end
