module Wishes
  class CreateFromTelegram < ApplicationService
    option :telegram_user, {} do
      option :chat_id
      option :username, optional: true
      option :firstname, optional: true
      option :lastname, optional: true
    end
    option :message_text

    def call
      Wishes::Create.call(user_id: user.id, wish: Wishes::PrepareFromText.call(message_text))
    end

    private

    def user
      @user ||= user_factory.find_or_create_from_telegram(telegram_user.to_h.symbolize_keys)
    end

    def user_factory
      @user_factory ||= FactoryRegistry.for(:user)
    end
  end
end
