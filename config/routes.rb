Rails.application.routes.draw do
  get 'braintree/new'
  root 'welcome#index'
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]
  # resources :listings, controller: "listings" 
  #   resource :reservations
  # end

  resources :users, controller: "users", exclude: [:new] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
    resources :listings, exclude: [:index] do 
      resources :reservations, exclude: [:show, :index]
    end 
  end

  # resources :reservations, controller: "reservations"

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  get "/create_listings" => "listings#new", as: "create_listings"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/auth/:provider/callback" => "sessions#create_from_omniauth" 
  post "/listings/verify" => "listings#verify", as: "verify_listings"
  # get "/listings" => "listings#verify", as: "verified_listings"
  post "/listings/show/nav/:listing_id" => "listings#navigate", as: "navigate_listings" 
  get "/listings" => "listings#index", as: "listings"
  get "/yourlistings" => "listings#yourlistings", as: "yourlistings"
  get "/reservations/show" => "reservations#show", as: "reservations_for_homes"
  get "/yourreservations" =>"reservations#index", as: "your_reservations"
  # get "/listing/:id" => "listings#navigate", as: "navigate_listings" 
  post "braintree/checkout" 

end
