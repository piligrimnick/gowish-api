module Users
  class FindOrCreateFromTelegram < ApplicationService
    option :chat_id
    option :username, optional: true
    option :firstname, optional: true
    option :lastname, optional: true

    def call
      user_factory.find_or_create_from_telegram(
        chat_id: chat_id,
        username: username,
        firstname: firstname,
        lastname: lastname
      )
    end

    private

    def user_factory
      @user_factory ||= FactoryRegistry.for(:user)
    end
  end
end
