Rails.application.routes.draw do
  root    'top_pages#home'
  get     '/signup' => 'users#new'
  get     '/login'  => 'sessions#new'
  post    '/login'  => 'sessions#create'
  delete  '/logout' => 'sessions#destroy'
  resources :users
end
