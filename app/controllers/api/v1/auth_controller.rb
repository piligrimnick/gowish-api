module Api
  module V1
    class AuthController < Doorkeeper::TokensController
      def create
        user = user_factory.find(authorize_response.token.resource_owner_id)

        headers.merge!(authorize_response.headers)

        render json: authorize_response.body.merge(user.secure_attributes),
               status: authorize_response.status
      rescue Doorkeeper::Errors::DoorkeeperError => e
        handle_token_exception(e)
      end

      private

      def user_factory
        @user_factory ||= FactoryRegistry.for(:user)
      end
    end
  end
end
