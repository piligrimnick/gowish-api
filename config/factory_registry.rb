class FactoryRegistry
  FactoryNotFound = Class.new(StandardError)

  class << self
    def register(type, factory)
      factories[type] = factory
    end

    def register_many(collection = {})
      collection.each do |name, factory|
        register(name, factory)
      end
    end

    def for(type)
      factories.fetch(type) do
        raise(FactoryNotFound, "Factory #{type} not registered")
      end
    end

    private

    def factories
      @factories ||= {}
    end
  end

  private

  def initialize(*)
    raise 'Should not be initialiazed'
  end
end
