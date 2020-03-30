class UserFactory < ApplicationFactory
  def find_or_create_from_telegram(chat_id:, username: nil, firstname: nil, lastname: nil)
    User.create_with(
      username: username,
      firstname: firstname,
      lastname: lastname
    ).find_or_create_by!(telegram_id: chat_id)
  end
end
