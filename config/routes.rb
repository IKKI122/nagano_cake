Rails.application.routes.draw do
  namespace :admin do
    root to: 'homes#top'
    get 'items/index'
    get 'items/new'
    get 'items/show'
    get 'items/edit'
  end
  
  namespace :public do
    root to: 'homes#top'
    get "/about"=>"homes#about", as:"about"
    get 'items/index'
    get 'items/show'
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
