Rails.application.routes.draw do
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  # Defines the root path route ("/")
  # root "posts#index"
  
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  namespace :api do
    namespace :v1 do
      resources :shows, only: [:index, :show, :create, :update, :destroy]
    end
  end
  # get 'shows', to: 'shows#index'
  # get 'shows/:id', to: 'shows#show'
  # post 'shows', to: 'shows#create'
  # put 'shows/:id', to: 'shows#update'
  # delete 'shows/:id', to: 'shows#destroy'
end
