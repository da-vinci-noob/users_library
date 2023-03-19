Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' },
                     defaults: { format: 'json' }
  root 'vue#index'
  get '/*path', to: 'vue#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
