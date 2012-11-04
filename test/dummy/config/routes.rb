Rails.application.routes.draw do

  root :to => "projects#index"

  resources :projects do
    match "rpcextjs331" => 'projects#rpcextjs331', :on => :collection
    match "rpcextjs410" => 'projects#rpcextjs410', :on => :collection
  end

  mount Extr::Engine => "/extr"
end

