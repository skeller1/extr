Extr::Engine.routes.draw do
end

Rails.application.routes.draw do
   post "#{Extr::Config::ROUTER_PATH}", to: "extr/router#direct",
      format: false,
      defaults: { format: :json }
end

