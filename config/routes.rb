Rails.application.routes.draw do
  root 'top_pages#home'
  get  '/signup' => 'users#new'
  resources :users
end
