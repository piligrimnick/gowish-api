module Api
  module V1
    class AuthController < Doorkeeper::TokensController
      def create
        response = authorize_response

        # Check if response is an error
        if response.is_a?(Doorkeeper::OAuth::ErrorResponse)
          headers.merge!(response.headers)
          render json: response.body, status: response.status
          return
        end

        user = user_factory.find(response.token.resource_owner_id)
        user_struct = UserStruct.new(user.attributes)

        headers.merge!(response.headers)

        render json: response.body.merge(user_struct.secure_attributes),
               status: response.status
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
