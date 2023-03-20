Rails.application.routes.draw do
  devise_for :users, controllers: {
                       sessions: 'users/sessions',
                       registrations: 'users/registrations',
                       passwords: 'users/passwords'
                     },
                     defaults: { format: 'json' }

  # API Routes
  scope :api, defaults: { format: :json } do
    scope :v1 do
      devise_scope :user do
        post 'add_files', to: 'api/v1/users#add_files'
        post 'delete_file', to: 'api/v1/users#delete_file'
        get 'show_public_files', to: 'api/v1/users#show_public_files'
        post 'copy_file', to: 'api/v1/users#copy_file'
        post 'toggle_private_file', to: 'api/v1/users#toggle_private_file'
        get 'user_files', to: 'api/v1/users#user_files'
        get 'check_user', to: 'api/v1/users#check_user'
      end
    end
  end
  root 'vue#index'
  get '/*path', to: 'vue#index', constraints: ->(req) { req.path.exclude?('active_storage') }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
