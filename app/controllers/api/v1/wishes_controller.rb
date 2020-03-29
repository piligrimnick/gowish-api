module Api
  module V1
    class WishesController < ApplicationController
      def_param_group :wish do
        param :wish, Hash, required: true do
          param :body, String, desc: 'Text description'
          param :url, String, desc: 'url'
        end
      end

      api :GET, '/wishes'
      def index
        render json: wishes_repo.all
      end

      api :GET, '/wishes/:id'
      param :id, :number, required: true, desc: 'id of the requested wish'
      def show
        render json: wish
      end

      api :POST, '/wishes'
      param_group :wish
      def create
        render json: wish_factory.create(wish_params)
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

      def wishes_repo
        @wishes_repo ||= RepositoryRegistry.register(
          :user_wishes,
          WishesRepository.new(gateway: current_resource_owner.wishes)
        )
      end

      def wish_factory
        @wish_factory ||= FactoryRegistry.register(
          :user_wish,
          WishFactory.new(gateway: current_resource_owner.wishes)
        )
      end

      def wish_params
        params.require(:wish).permit(%i[body url])
      end
    end
  end
end
