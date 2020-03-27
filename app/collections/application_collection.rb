class ApplicationCollection < Array
  def initialize(objects, struct = ApplicationStruct)
    super(objects.map do |object|
      struct.new(object.attributes)
    end)
  end
end
