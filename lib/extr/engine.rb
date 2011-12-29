module Extr
  class Engine < Rails::Engine

    initializer "register_mime_type_for_extr" do |app|
     Mime::Type.register 'application/ext', :ext
    end

  end
end

