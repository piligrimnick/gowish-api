class ApplicationFactory
  def initialize(gateway:, struct:)
    @gateway = gateway
    @struct = struct
  end

  def create(params = {})
    @object = gateway.create!(params)

    structurize
  end

  def update(id, params = {})
    @object = gateway.find(id)

    object.update!(params)

    structurize
  end

  def find(id, filter_params = {})
    @object = gateway.where(filter_params.merge(id: id)).take

    structurize
  end

  def destroy(id, filter_params = {})
    gateway.where(filter_params.merge(id: id)).take&.destroy!
  end

  def first
    @object = gateway.first

    structurize
  end

  def last
    @object = gateway.last

    structurize
  end

  private

  attr_reader :gateway, :struct, :object

  def structurize
    attributes = object.attributes

    struct.new(attributes)
  end
end
