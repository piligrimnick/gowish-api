class ApplicationService
  extend Dry::Initializer # use `param` and `option` for dependencies

  include Rails.application.routes.url_helpers

  class << self
    # Instantiates and calls the service at once
    def call(*args, **kwargs, &block)
      new(*args, **kwargs).call(&block)
    end

    # Accepts both symbolized and stringified attributes
    def new(*args, **kwargs)
      kwargs = args.pop.symbolize_keys.merge(kwargs) if args.last.is_a?(Hash)
      super(*args, **kwargs)
    end
  end
end
