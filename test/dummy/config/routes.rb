Rails.application.routes.draw do

  root :to => "projects#index"

  resources :projects do
    get :upload, :on => :collection
  end

  mount Extr::Engine => "/extr"
end

