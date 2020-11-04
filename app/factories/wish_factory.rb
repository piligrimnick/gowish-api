class WishFactory < ApplicationFactory
  def initialize(gateway: Wish, struct: WishStruct)
    super
  end

  def realise(wish_id)
    @object = gateway.find(wish_id)
    object.realised!

    structurize
  end

  def book(wish_id:, booker_id:)
    @object = gateway.update(wish_id, booker: User.find(booker_id))

    structurize
  end

  def unbook(wish_id:, booker_id:)
    @object = Wish.find(wish_id)
    object.booking.destroy! if object.booking.user_id == booker_id
    @object.reload
    structurize
  end

  private

  def structurize
    attributes = object.attributes
    attributes[:user] = UserStruct.new(object.user.attributes).secure_attributes
    if object.booking.present?
      attributes[:booking] = BookingStruct.new(object.booking.attributes).to_h
      attributes[:booker] = UserStruct.new(object.booker.attributes).to_h
    end

    struct.new(attributes)
  end
end
