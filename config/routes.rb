Rails.application.routes.draw do
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  scope module: :public do
    root to: 'homes#top'
    get "/about"=>"homes#about", as:"about"
    resources :items, only: [:index, :show]
    resources :customers, only: [:edit, :update]
    get '/customers/my_page'=>'customers#show', as:'show'
    get '/customers/unsubscribe'=>'customers#unsubscribe', as:'unsubscribe'
    patch '/customers/withdraw'=>'customers#withdraw', as:'withdraw'
    resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :orders, only: [:new, :confirm, :create, :complete, :index, :show]
  end
  
  namespace :admin do
    root to: 'homes#top'
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_details, only: [:update]
    resources :genres, only: [:index, :create, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
