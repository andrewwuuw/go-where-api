Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/sign_up", to: "users#create"
  post "/sign_in", to: "users#sign_in"
  delete "/sign_out", to: "users#sign_out"

end
