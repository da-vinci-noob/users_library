Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' },
                     defaults: { format: 'json' }

  # API Routes
  scope :api, defaults: { format: :json } do
    scope :v1 do
      post 'add_files', to: 'api/v1/users#add_files'
      devise_scope :user do
        get 'check_user', to: 'api/v1/users#check_user'
      end
    end
  end
  root 'vue#index'
  get '/*path', to: 'vue#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
