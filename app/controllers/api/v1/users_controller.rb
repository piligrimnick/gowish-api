module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :doorkeeper_authorize!, only: [:show]

      api :GET, 'users/:id'
      param :id, String, required: true, desc: 'id of the requested user'
      def show
        render json: user_factory.find(params[:id])
      end

      private

      def user_factory
        @user_factory ||= FactoryRegistry.for(:user)
      end
    end
  end
end
