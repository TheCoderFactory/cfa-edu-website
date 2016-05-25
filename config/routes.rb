Rails.application.routes.draw do
  root "home#index"
  devise_for :admins, skip: [:sessions, :passwords, :registrations]

  as :admin do
    get     "admin/login"           =>  "admins/sessions#new", as: :new_admin_session
    post    "admin/login"           =>  "admins/sessions#create", as: :admin_session
    delete  "admin/logout"          =>  "admins/sessions#destroy", as: :destroy_admin_session
    get     "admin/edit-account"    =>  "admins/registrations#edit", as: :edit_admin_account
    patch   "admin/edit-account"    =>  "admins/registrations#update", as: :update_admin_account
    delete  "admin/delete-account"  =>  "admins/registrations#destroy", as: :delete_admin_account
  end

  resources :courses
  resources :intakes
  resources :bookings
  resources :promo_codes

  get "admin/dashboard", to: "admin_dashboard#index"

  get "fast-track", to: "fast_track#index"
  get "fast-track/apply", to: "fast_track#apply"
  get "fast-track/women-in-tech-scholarship", to: "fast_track#wit_scholarship_info"
  get "fast-track/women-in-tech-scholarship/apply", to: "fast_track#wit_scholarship_apply"

  get "about", to: "pages#about"
  get "meet-our-alumni", to: "pages#alumni"
  get "career-outcomes", to: "pages#career_outcomes"
  get "contact", to: "pages#contact"
  get "faq", to: "pages#faq"
  get "information-toolkit", to: "pages#information_toolkit"
  get "meet-our-instructors", to: "pages#instructors"
  get "privacy", to: "pages#privacy"
  get "video-archive", to: "pages#video_archive"
end
