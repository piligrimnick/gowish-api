class WishesRepository < ApplicationRepository
  def initialize(gateway: Wish, collection: WishesCollection, struct: WishStruct)
    super
  end
end
