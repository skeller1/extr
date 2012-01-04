module Extr
  module ApplicationHelper

  def ext_base_tag
    "<base href=\"#{base}\" />".html_safe
  end

  def ext (theme = 'xtheme-blue',debug = nil, include_stylesheets = true)
    if debug.nil?
      debug = Rails.env.development? ? true : false
    end

    if include_stylesheets
      output = stylesheet_link_tag "CSS/ext-all-notheme.css"
      output += stylesheet_link_tag "CSS/#{theme}.css"
    end

    if debug
      output += javascript_include_tag "JavaScript/adapter/ext/ext-base-debug.js"
      output += javascript_include_tag "JavaScript/ext-all-debug.js"
    else
      output += javascript_include_tag "JavaScript/adapter/ext/ext-base.js"
      output += javascript_include_tag "JavaScript/ext-all.js"
    end

    output += javascript_tag do
      <<HERE
      Ext.BLANK_IMAGE_URL = '#{asset_path("images/default/s.gif")}';
      Ext.FlashComponent.EXPRESS_INSTALL_URL = '#{asset_path("Flash/expressinstall.swf")}';
      Ext.chart.Chart.CHART_URL = '#{asset_path("Flash/charts.swf")}';
HERE

    end

    return output.html_safe
  end

  def ext_direct_provider(namespace)
    #begin
    config = {
      'url'       =>   Extr::Config::ROUTER_PATH,
      'type'      =>   'remoting',
      'actions'   =>   Extr::Config.model_config.merge(Extr::Config.controller_config),
      'namespace' =>   namespace || "App" ,
      'srv_env'   =>    Rails.env
    }
    api="REMOTING_API = #{config.to_json}"

    forgery = "(function() {
  var originalGetCallData = Ext.direct.RemotingProvider.prototype.getCallData;
  Ext.override(Ext.direct.RemotingProvider, {
   getCallData: function(t) {
    var defaults = originalGetCallData.apply(this, arguments);
    return Ext.apply(defaults, {
     #{request_forgery_protection_token}: '#{form_authenticity_token}'
    });
   }
  })
  })();"


    javascript_tag forgery+"Ext.Direct.addProvider(#{api});"

    #rescue
    #  javascript_tag "alert('Something went wrong');"
   # end

    #controller_match = Rails.root.join('app', 'controllers','**', '*.rb')
    #controller_files=Dir.glob(domain_match)


    #controller_files.each do |f|
    #  controller_name = File.basename(f,'.rb').capitalize
    #end

    #return 'Ext.Direct.addProvider(' . json_encode($providerConfig) . ');' . chr(10);
  end

  private

  def base
    request.protocol+request.raw_host_with_port
  end

  end
end

