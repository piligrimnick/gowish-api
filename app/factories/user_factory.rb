class UserFactory < ApplicationFactory
  def initialize(gateway: User, struct: UserStruct)
    super
  end

  def find_or_create_from_telegram(chat_id:, username: nil, firstname: nil, lastname: nil)
    @object = User.create_with(
      username: username,
      firstname: firstname,
      lastname: lastname
    ).find_or_create_by!(telegram_id: chat_id)

    structurize
  end
end
