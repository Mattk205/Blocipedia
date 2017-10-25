Rails.application.routes.draw do
  resources :charges, only: [:new, :create, :edit, :update]
  resources :wikis
  root to: 'welcome#index'

  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
