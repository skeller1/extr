module Extr
  module ApplicationHelper

  def ext_base_tag
    "<base href=\"#{base}\" />".html_safe
  end

  def ext_direct_provider
   namespaced_apis=""
   Extr::Config.controller_config.each do |namespace,extr_config|
    config = {
      'url'       =>   Extr::Config::ROUTER_PATH,
      'type'      =>   'remoting',
      'actions'   =>   Extr::Config.controller_config[namespace],
      'namespace' =>   namespace,
      'srv_env'   =>   Rails.env
    }
    api="REMOTING_API_#{namespace.upcase} = #{config.to_json}"
    namespaced_apis+="Ext.Direct.addProvider(#{api});"
   
   end
    
   forgery = "(function() {
  Ext.Ajax.defaultHeaders = {
    'X-CSRF-Token': '#{form_authenticity_token}'
  };

  })();"

   javascript_tag forgery+namespaced_apis
  end

  private

  def base
   request.protocol+request.raw_host_with_port
  end

  end
end

