module Wishes
  class Realise < ApplicationService
    option :wish_id

    def call
      factory.realise(wish.id)
      # update_statistic
      send_email if user.email.present?
    end

    private

    def send_mail
      mail_client.call({
        payload: {
          template_id: ENV['REALISED_TEMPLATE_ID'],
          from: ENV['FROM_EMAIL'],
          to: user.email,
          dynamic_template_data: {
            link: "http://loclahost"
          }
        }
      })
    end

    def user
      @user ||= user_factory.find(wish.user_id)
    end

    def wish
      @wish ||= factory.find(wish_id)
    end

    def user_factory
      @user_factory ||= FactoryRegistry.for(:user)
    end

    def factory
      @wish_factory ||= FactoryRegistry.for(:wish)
    end

    def mail_client
      @mail_client ||= MailingServiceClient::Email.new(provider_name: :send_grid)
    end
  end
end
