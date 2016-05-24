Rails.application.routes.draw do
  root "home#index"

  get "fast-track", to: "fast_track#index"
  get "fast-track/apply", to: "fast_track#apply"
end
