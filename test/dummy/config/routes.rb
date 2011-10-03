Rails.application.routes.draw do

  resources :projects

  mount Extr::Engine => "/extr"
end
