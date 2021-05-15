Rails.application.routes.draw do
  
  devise_for :customer,
    only: [:sessions, :registrations],
    path: "customers",
    controllers: {
      sessions:  "public/sessions",
      registrations: "public/registrations"
    }
  
  
  scope module: :public do
    root to: "homes#top"
    get "about", to: "home#about"
    resource :customers, only: [:edit, :update]  do
      get "my_page", to: "customers#show"
    end
    get "customers/:id/out_confirm", to: "customers#out_confirm"
    patch "customers/:id/out", to: "customers#out"
    resources :products, only: [:index, :show]
    resources :cart_products, only: [:index, :create, :update, :destroy]
    delete "cart_products/destroy_all", to: "cart_products#destroy_all"
    resources :orders, only: [:index, :create, :new, :show]
    post "orders/confirm", to: "orders#confirm"
    get "orders/thanks", to: "orders#thanks"
    resources :addresses, except: [:new, :show]
  end
  
  devise_for :admin,
    only: [:sessions],
    path: "admin",
    controllers: {
      sessions: "admin/sessions"
    }
  
  namespace :admin do
    root to: "homes#top"
    resources :customers, only: [:index, :edit, :show, :update]
    resources :products
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
  
end
