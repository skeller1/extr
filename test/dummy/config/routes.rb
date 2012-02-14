Rails.application.routes.draw do

  root :to => "projects#index"

  resources :projects

  mount Extr::Engine => "/extr"
end

