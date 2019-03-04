Rails.application.routes.draw do
  resources :charities
  resources :credit_receipts
  resources :donations
  resources :sponsors
  resources :confirms
  resources :events
  resources :users

  post "/login", to:"autho#login"
  post "/users/login", to:"users#login"
  get "/current_user", to:"auth#get_user_from_token"
  post "/confirms/updateconfirms", to:"confirms#update"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
