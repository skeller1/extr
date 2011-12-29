Extr::Engine.routes.draw do
 end

Rails.application.routes.draw do
   match "#{Extr::Config::ROUTER_PATH}" => "extr/router#direct",
   :format => false,
   :defaults => { :format => :ext },
   :via => :post
end

