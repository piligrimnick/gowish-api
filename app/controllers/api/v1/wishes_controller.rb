module Api
  module V1
    class WishesController < ApplicationController
      skip_before_action :doorkeeper_authorize!, only: [:user_wishes]

      def_param_group :wish do
        param :wish, Hash, required: true do
          param :body, String, desc: 'Text description'
          param :url, String, desc: 'url'
        end
      end

      api :GET, '/user_wishes/:user_id'
      param :user_id, String, required: true, desc: 'User ID'
      def user_wishes
        render json: wishes_repo.filter(user_id: params[:user_id])
      end

      api :GET, '/wishes'
      def index
        render json: current_user_wishes_repo.all
      end

      api :GET, '/wishes/:id'
      param :id, :number, required: true, desc: 'id of the requested wish'
      def show
        render json: wish
      end

      api :POST, '/wishes'
      param_group :wish
      def create
        render json: Wishes::Create(current_user, wish_params)
      end

      api :PUT, '/wishes/:id'
      param :id, :number, required: true, desc: 'id of the requested wish'
      param_group :wish
      def update
        render json: wish_factory.update(params[:id], wish_params)
      end

      api :DELETE, '/wishes/:id'
      param :id, :number, required: true, desc: 'id of the requested wish'
      def destroy
        render json: wish_factory.destroy(wish.id)
      end

      private

      def wish
        @wish ||= wish_factory.find(params[:id])
      end

      def current_user_wishes_repo
        @current_user_wishes_repo ||= WishesRepository.new(gateway: current_user.wishes)
      end

      def wishes_repo
        @wishes_repo ||= RepositoryRegistry.for(:wishes)
      end

      def wish_factory
        @wish_factory ||= WishFactory.new(gateway: current_user.wishes)
      end

      def wish_params
        params.require(:wish).permit(%i[body url])
      end
    end
  end
end
