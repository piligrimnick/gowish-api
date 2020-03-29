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
      repo = repositories.fetch(type) do
        raise(RepositoryNotFound, "Repository #{type} not registered")
      end

      if Rails.env.development?
        repo.class.new(
          gateway: repo.instance_variable_get(:@gateway),
          collection: repo.instance_variable_get(:@collection),
          struct: repo.instance_variable_get(:@struct)
        )
      else
        repo
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
