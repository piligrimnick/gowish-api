module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        def create
          build_resource(sign_up_params)
          resource.save
          if resource.persisted?
            expire_data_after_sign_in! unless resource.active_for_authentication?

            render json: resource
          else
            clean_up_passwords resource
            set_minimum_password_length
            respond_with resource
          end
        end
      end
    end
  end
end
