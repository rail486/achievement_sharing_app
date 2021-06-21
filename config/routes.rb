Rails.application.routes.draw do
  get 'timelines/index'
  root    'top_pages#home'
  get     '/signup'                   => 'users#new'
  get     '/settings'                 => 'users#setting'
  get     '/users/:id/edit_profile'   => 'users#edit_profile'
  get     '/users/:id/edit_password'  => 'users#edit_password'
  get     '/users/:id/delete_account' => 'users#delete_account'
  get     '/login'                    => 'sessions#new'
  post    '/login'                    => 'sessions#create'
  delete  '/logout'                   => 'sessions#destroy'
  resources :users do
    member do
      patch :update_profile
      patch :update_password
    end
  end
end
