module Extr
  module ApplicationHelper

  def ext_base_tag
    "<base href=\"#{base}\" />".html_safe
  end

  def ext_direct_provider(namespace = "App")
  p Extr::Config.controller_config
   config = {
      'url'       =>   Extr::Config::ROUTER_PATH,
      'type'      =>   'remoting',
      'actions'   =>   Extr::Config.controller_config,
      'namespace' =>   namespace,
      'srv_env'   =>   Rails.env
   }
   api="REMOTING_API = #{config.to_json}"

   forgery = "(function() {
  Ext.Ajax.defaultHeaders = {
    'X-CSRF-Token': '#{form_authenticity_token}'
  };

  //var originalGetCallData = Ext.direct.RemotingProvider.prototype.getCallData;
  //Ext.override(Ext.direct.RemotingProvider, {
  // getCallData: function(t) {
  //  var defaults = originalGetCallData.apply(this, arguments);
  //  return Ext.apply(defaults, {
  //   #{request_forgery_protection_token}: '#{form_authenticity_token}'
  //  });
  // }
  //})
  })();"

   javascript_tag forgery+"Ext.Direct.addProvider(#{api});"
  end

  private

  def base
   request.protocol+request.raw_host_with_port
  end

  end
end

