Rails.application.routes.draw do
  resources :charities
  resources :credit_receipts
  resources :donations
  resources :sponsers
  resources :confirms
  resources :events
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
