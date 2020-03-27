# Load the Rails application.
require_relative 'application'
require_relative 'repository_registry'
require_relative 'factory_registry'

# Initialize the Rails application.
Rails.application.initialize!

REPOSITORIES = {
  users: UsersRepository.new(gateway: User, collection: UsersCollection, struct: UserStruct)
}

FACTORIES = {
  user: UserFactory.new(gateway: User, struct: UserStruct)
}

RepositoryRegistry.register_many(REPOSITORIES)
FactoryRegistry.register_many(FACTORIES)
