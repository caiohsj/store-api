Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # mount Sidekiq::Web => '/sidekiq'

  devise_for :users, controllers: { passwords: "passwords" }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:create, :update, :show] do
        collection do
          post :sign_in, controller: :sessions, action: :create
          post :facebook_auth, controller: :sessions, action: :facebook_auth
          put :recover_password
          put :update_password, controller: :passwords, action: :update
        end
      end
    end
  end
end
