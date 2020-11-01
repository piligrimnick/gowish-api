class WishesRepository < ApplicationRepository
  def initialize(gateway: Wish, collection: WishesCollection, struct: WishStruct)
    super
  end

  # scopes:

  def active
    @gateway = gateway.active

    self
  end

  def realised
    @gateway = gateway.realised

    self
  end
end
