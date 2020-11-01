class WishFactory < ApplicationFactory
  def initialize(gateway: Wish, struct: WishStruct)
    super
  end

  def realise(wish_id)
    @object = gateway.find(wish_id)
    object.realised!

    structurize
  end
end
