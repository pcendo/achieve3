Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'instagrams/top'
  root :to => 'instagrams#top'
  
  resources :instagrams do
    collection do
      post :confirm
    end
  end

  resources :users, only: [:new, :create, :show, :edit ]
  resources :sessions, only: [:new, :create, :destroy ]
  resources :favorites, only: [:create, :destroy, :index, :show ]

end
