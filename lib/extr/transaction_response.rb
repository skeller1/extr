module Extr
 
 class TransactionResponse
  
  attr_reader :type, :tid, :action, :method, :result

  def initialize
   result
  end


  private

   def invoke_model_method(action, method, parameters, tid)
      result = {
        'type' => 'rpc',
        'tid' => tid,
        'action' => action,
        'method' => method
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
      result['result'] = return_val.nil? ? "" : return_val
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
        'type' => 'rpc',
        'tid' => tid,
        'action' => action,
        'method' => method,
        'result' => ""
      }

      controller_path = Config.get_controller_path(action)


      request_env = @env.dup

      request_env["PATH_INFO"] = "extr/#{controller_path}-#{method}/json"
      request_env["REQUEST_URI"] = "extr/#{controller_path}-#{method}/json"

      #status,headers,response=controller.constantize.action(method).call(controller_request)

      begin

       status,headers,response=@app.call(request_env)
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



   
 end

end
