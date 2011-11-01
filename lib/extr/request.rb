module Extr

 class ExtDirectRequest < Rack::Request
 	

  def initialize(env)
   @env = env
   @file_upload = false
   @transactions = get_raw_http
   super 
  end

  def transactions
   @transactions
  end

  def file_upload?
   @file_upload
  end

  
  private

  def get_raw_http
      params_key = @env["action_controller.request.request_parameters"] ? "action_controller.request.request_parameters" : "action_dispatch.request.request_parameters"
	parse @env[params_key]
      
    end


    def parse(data)
        return (data["_json"]) ? data["_json"] : [data]
    end

 end

end
