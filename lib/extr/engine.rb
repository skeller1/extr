module Extr
  class Engine < Rails::Engine

    initializer "register_mime_type_for_extr" do |app|
     Mime::Type.register 'application/ext', :ext
    end


    initializer "register_ext_renderer" do |app|
     ActionController::Renderers.add :ext do |template, options|
      str = render_to_string(template, options)
      p str
      #p "responder ext works now with default view: #{template}"
      #send_data str, :type => Mime::JSON, :disposition => :inline
     end
    end

  end
end

class ActionController::Responder

 def to_ext
  controller.render :ext => controller.action_name
 end

end

