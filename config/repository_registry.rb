class RepositoryRegistry
  RepositoryNotFound = Class.new(StandardError)

  class << self
    def register(type, repo)
      repositories[type] = repo
    end

    def register_many(collection = {})
      collection.each do |name, repo|
        register(name, repo)
      end
    end

    def for(type)
      repositories.fetch(type) do
        raise(RepositoryNotFound, "Repository #{type} not registered")
      end
    end

    private

    def repositories
      @repositories ||= {}
    end
  end

  private

  def initialize(*)
    raise 'Should not be initialiazed'
  end
end
