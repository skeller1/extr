module Extr
  class Engine < Rails::Engine

    initializer "register_mime_type_for_extr" do |app|
     Mime::Type.register 'application/ext', :ext
    end


    initializer "register_ext_renderer" do |app|
     ActionController::Renderers.add :ext do |name, options|
      p "responder ext works now with default #{name}"
      #send_data ToExt, :type => Mime::JSON
     end
    end

  end
end

class ActionController::Responder

 def to_ext
  controller.render :ext => "anja"
 end

end

