module Extr

 class ExtDirectJsonRequest < Rack::Request
 	
  def transactions
   @transactions ||= collect_transactions
  end


  private

  def collect_transactions
   begin
    arr = []
    raw_http_params.each do |req|
     t = Transaction.new(self, req['action'], req['method'], req['data'], req['tid'])
     arr << t if t.valid?
    end
   rescue => ex
    Rails.logger.error ex.message
    Rails.logger.error ex.backtrace
   ensure
    return arr
   end
  end

  def raw_http_params
   params_key = @env["action_controller.request.request_parameters"] ? "action_controller.request.request_parameters" : "action_dispatch.request.request_parameters"
   parse @env[params_key]
  end

  def parse(data)
   return (data["_json"]) ? data["_json"] : [data]
  end

 end

end
