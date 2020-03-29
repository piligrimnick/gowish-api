Rails.application.routes.draw do
  apipie
  use_doorkeeper do
    skip_controllers :applications, :authorized_applications
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :api, defaults: { format: :json }, path: 'api' do
    scope module: :v1, constraints: Constraints::ApiConstraint.new(version: 1, default: true) do
      devise_for :users, controllers: {
           registrations: 'api/v1/users/registrations',
       }, skip: [:sessions, :password]

       resources :wishes
    end
  end
end
