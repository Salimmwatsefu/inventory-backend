Rails.application.routes.draw do
  resources :employees
  resources :sales do
    collection do
      get 'report', to: 'sales#sales_report'
    end
  end

  resources :products


  post '/signup', to: 'users#create'
  get "/me", to: "users#show"
  post "/login", to: "users#login"
  delete "/logout", to: "users#destroy"
end
