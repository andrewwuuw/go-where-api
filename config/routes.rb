Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/sign_up", to: "users#create"
  post "/sign_in", to: "users#sign_in"
  delete "/sign_out", to: "users#sign_out"

  resources :friends, only: [:index, :create, :destroy] do
    collection do
        post "/apply/:id", to: "friends#apply"
        get "/applicant", to: "friends#applicant"
    end
  end

end
