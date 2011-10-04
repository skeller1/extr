# this is the router of Extr for EXT Direct, implemented as rack middleware
module Extr
  class Router

    def initialize(app, router_path)
      @app = app
      @router_path = router_path
    end

    def call(env)
      request = Rack::Request.new(env)
      @env = env
      if env["PATH_INFO"].match("^#{@router_path}") && request.post?
        result= form_post? ? process_form_rpc : process_raw_rpc
        [200, { "Content-Type" => "application/json"}, [result]]
      else
        @app.call(@env)
      end
    end

    def process_raw_rpc
      p "started process_raw_rpc"
      resp = []
      get_raw_http.each do |req|

        action = req['action']
        method = req['method']
        data = req['data']
        tid = req['tid']

        if Config.has_model?(action)
          p "model"
          resp << invoke_model_method(action, method, data, tid)
        else
          p "controller"
          resp << invoke_controller_method(action, method, data, tid)
        end

      end


      resp.to_json
    end

    def process_form_rpc
      p "started process_form_rpc"
      resp = []


      @env['rack.request.form_hash'].each do |req|

        #action = req['extAction']
        #method = req['extMethod']
        #data = req['data']
        #tid = req['extTID']


        resp << req

      end
      resp.to_json
      #"<html><body><textarea>#{resp.to_json}</textarea></body></html>"
    end

    def invoke_model_method(action, method, parameters, tid)
      result = {
        'type'    =>    'rpc',
        'tid'     =>    tid,
        'action'  =>    action,
        'method'  =>    method
      }

      unless Config.has_method?(action, method)
        raise "Invalid method:#{method} called on action:#{action}."
      end
      unless parameters.nil?
        p parameters.class
        return_val = action.constantize.send(method)
        #return_val = action.constantize.send(method, *normalize_params_for(action,parameters))
      else
        return_val = action.constantize.send(method)
      end
      result['result'] = return_val.nil? ?  "" : return_val
    rescue => e
      if Rails.env.development?
        Rails.logger.error result['type'] = 'exception'
        Rails.logger.error result['message'] = e.message
        Rails.logger.error result['where'] = e.backtrace.join("\n")
      end
    ensure
      return result
    end

    def invoke_controller_method(action, method, parameters, tid)

      result = {
        'type'    =>    'rpc',
        'tid'     =>    tid,
        'action'  =>    action,
        'method'  =>    method,
        'result' => ""
      }

      controller_path = Config.get_controller_path(action)


      request_env = @env.dup

      request_env["PATH_INFO"] = "extr/#{controller_path}-#{method}/json"
      request_env["REQUEST_URI"] = "extr/#{controller_path}-#{method}/json"

      #status,headers,response=controller.constantize.action(method).call(controller_request)

      begin

       status,headers,response=@app.call(request_env)
       p response
       result['result'] = response ? response.body : ""
       result['result'] = ActiveSupport::JSON.decode(result['result'])

       result
      rescue => e
       if Rails.env.development?
        Rails.logger.error result['type'] = 'exception'
        Rails.logger.error result['message'] = e.message
        Rails.logger.error result['where'] = e.backtrace.join("\n")
        result["result"] = ""
       else
        result["result"] = {}
       end
       result
      end
    end

    private

    #todo make params
    def normalize_params_for(action, params)


      unless form_post?
        params
      end


    end


    def get_raw_http
      params_key = @env["action_controller.request.request_parameters"] ? "action_controller.request.request_parameters" : "action_dispatch.request.request_parameters"
      parse @env[params_key]
    end


    def parse(data)
        return (data["_json"]) ? data["_json"] : [data]
    end


    def form_post?
      @env['rack.request.form_hash']
    end

  end
end

