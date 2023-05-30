Rails.application.routes.draw do
  resources :sales do
    collection do
      get 'report', to: 'sales#sales_report'
    end
  end

  resources :products

  root to: 'products#index'
end
