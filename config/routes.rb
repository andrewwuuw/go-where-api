Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/sign_up", to: "users#create"
  post "/sign_in", to: "users#sign_in"

  resources :friends, only: [:index, :create, :destroy] do
    collection do
      get "/applicant", to: "friends#applicant"
      post "/apply/:user_id", to: "friends#apply"
      delete "/apply/:id", to: "friends#reject"
    end
  end

  resources :followers, only: [:index, :create, :destroy] do
    collection do
      get "/applicant", to: "followers#applicant"
      post "/apply/:user_id", to: "followers#apply"
      delete "/apply/:id", to: "followers#reject"
    end
    
  end

end
