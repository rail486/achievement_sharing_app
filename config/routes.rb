Rails.application.routes.draw do
  get 'calendars/index'
  get 'timelines/index'
  root    'top_pages#home'
  get     '/signup'                   => 'users#new'
  get     '/settings'                 => 'users#setting'
  get     '/users/:id/edit_profile'   => 'users#edit_profile'
  get     '/users/:id/edit_password'  => 'users#edit_password'
  get     '/users/:id/delete_account' => 'users#delete_account'
  get     '/deleted'                  => 'users#deleted'
  get     '/login'                    => 'sessions#new'
  post    '/login'                    => 'sessions#create'
  delete  '/logout'                   => 'sessions#destroy'
  
  #timeline
  get     'tasklist'                  => 'tasklists#index'
  #get     'calendar'                  => 'calendars#index'

  resources :users do
    member do
      patch :update_profile
      patch :update_password
      get :following
      get :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
end
