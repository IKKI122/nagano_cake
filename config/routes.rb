Rails.application.routes.draw do
  namespace :public do
    get 'cart_items/index'
  end
  
  namespace :admin do
    root to: 'homes#top'
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end
  
  namespace :public do
    root to: 'homes#top'
    get "/about"=>"homes#about", as:"about"
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update, :unsubscribe, :withdraw]
    resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]
  end
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  devise_for :customers,skip: [:passwords] ,controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
