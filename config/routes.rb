Rails.application.routes.draw do
  root "home#index"

  get "fast-track", to: "fast_track#index"
  get "fast-track/apply", to: "fast_track#apply"
  get "fast-track/women-in-tech-scholarship", to: "fast_track#wit_scholarship_info"
  get "fast-track/women-in-tech-scholarship/apply", to: "fast_track#wit_scholarship_apply"

  get "workshop", to: "workshop#index"

  get "corporate", to: "corporate#index"

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
