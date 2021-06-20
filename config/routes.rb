Rails.application.routes.draw do
  get 'timelines/index'
  root    'top_pages#home'
  get     '/signup'   => 'users#new'
  get     '/settings' => 'users#setting'
  get     '/login'    => 'sessions#new'
  post    '/login'    => 'sessions#create'
  delete  '/logout'   => 'sessions#destroy'
  resources :users
end
