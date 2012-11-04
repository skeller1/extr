Rails.application.routes.draw do

  root :to => "projects#index"

  resources :projects do
   match "rpcextjs410" => 'projects#rpcextjs410', :on => :collection
  end

  mount Extr::Engine => "/extr"
end

