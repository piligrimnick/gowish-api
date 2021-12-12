class WishFactory < ApplicationFactory
  include Rails.application.routes.url_helpers

  def initialize(gateway: Wish, struct: WishStruct)
    super
  end

  def create(params = {})
    @object = gateway.create!(params.except(:picture))
    @object.picture.attach(io: params[:picture], filename: @object.id) if params[:picture].present?
    @object.save

    structurize
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

    if object.picture.present?
      attributes[:picture_url] = rails_blob_path(object.picture, only_path: true)
    end

    struct.new(attributes)
  end
end
