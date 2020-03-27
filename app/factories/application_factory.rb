class ApplicationFactory
  def initialize(gateway:, struct:)
    @gateway = gateway
    @struct = struct
  end

  def create(params = {})
    @object = gateway.create!(params)

    structurize
  end

  def find(id)
    @object = gateway.find(id)

    structurize
  end

  def destroy(id)
    gateway.destroy!(id)
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
