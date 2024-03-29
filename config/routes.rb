Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :customers
      resources :courts
      post "courts/book", to: "bookings#book"
      post "courts/booked", to: "bookings#booked"
      post "courts/cancel", to: "bookings#cancel"
    end
  end
end
