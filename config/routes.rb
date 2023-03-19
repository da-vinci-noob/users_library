Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' },
                     defaults: { format: 'json' }
  root 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
