Rails.application.routes.draw do
  resources :sales
  resources :products

  root to: 'products#index'
  get '/sales/report', to: 'sales#sales_report'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
