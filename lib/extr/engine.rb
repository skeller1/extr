module Extr
  class Engine < Rails::Engine
    #isolate_namespace Extr

    initializer "extr.add_middleware with config" do |app|
      app.middleware.use 'Extr::Router', Extr::Config::ROUTER_PATH
    end

  end
end

