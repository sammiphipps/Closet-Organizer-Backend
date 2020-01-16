Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post "login", to: "authentication#login"
  get "/clothing_items/:username", to: "clothing_items#index_by_users"
  
  resources :clothing_items, except: [:new, :edit]
  resources :clothing_categories, only: [:index, :show]
  resources :users, only: [:create]

end 