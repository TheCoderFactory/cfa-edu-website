Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
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

  resources :courses, path: "admin/courses"
  resources :intakes, path: "admin/intakes"
  get "intake-details", to: "intakes#intake_details"
  get "admin/bookings/new", to: "bookings#admin_new"
  post "admin/bookings", to: "bookings#admin_create"
  resources :bookings, path: "admin/bookings", except: [:new, :create]
  resources :promo_codes, path: "admin/promo-codes"
  get "validate-promo-code", to: "promo_codes#validate_promo_code"
  resources :fast_track_payments, path: "admin/fast-track-payments", :except => [:new, :create]
  get "ftpay/:pay_type", to: "fast_track_payments#new"
  post "ftpay", to: "fast_track_payments#create"

  get "admin/dashboard", to: "admin_dashboard#index"
  get "admin", to: "admin_dashboard#index"
  get "fast-track", to: "fast_track#index"
  get "fast-track/apply", to: "fast_track#apply"
  get "fast-track/women-in-tech-scholarship", to: "fast_track#wit_scholarship_info"
  get "fast-track/women-in-tech-scholarship/apply", to: "fast_track#wit_scholarship_apply"
  get "fast-track/australian-innovation-scholarship", to: "fast_track#australian_innovation_scholarship"
  get "fast-track/australian-innovation-scholarship/apply", to: "fast_track#australian_innovation_scholarship_apply"

  get "short-courses", to: "workshop#index"

  get "corporate", to: "corporate#index"

  get "kids-coding", to: "kids_coding#index"

  get "blog", to: "blog#index"
  resources :posts, path: "admin/posts", except: [:show] do
    collection { post :import }
  end
  get "/posts/:id", to: "posts#show", as: :show_post

  get "about-coder-factory-academy", to: "pages#about"
  # get "meet-our-alumni", to: "pages#alumni"
  get "career-outcomes", to: "pages#career_outcomes"
  get "confirmation", to: "pages#confirmation"
  get "contact", to: "pages#contact"
  get "curriculum", to: "pages#curriculum"
  get "faq", to: "pages#faq"
  get "information-toolkit", to: "pages#information_toolkit"
  get "meet-your-instructors", to: "pages#instructors"
  get "partners", to: "pages#partners"
  get "payment-options", to: "pages#payment_options"
  get "privacy", to: "pages#privacy"
  get "video-archive", to: "pages#video_archive"

  get ":course_type/:course_id", to: "bookings#new", as: :booking_new
  post ":course_type/:course_id", to: "bookings#create", as: :create_booking


  # routes to be redirected
  get "/information-sessions/new", to: redirect("/fast-track")
  get "/women-in-tech", to: redirect("/fast-track/women-in-tech-scholarship")
  get "/coding-courses", to: redirect("/short-courses")
  get "/coding-workshops-for-business-and-schools", to: redirect("/corporate")
  get "/community", to: redirect("/")
  get "/learn-to-code", to: redirect("/short-courses")
  match "/learn-to-code/:id", to: redirect("/short-courses"), via: :get

  get 'sitemap.xml', :to => 'sitemap#index', :defaults => {:format => 'xml'}
end
