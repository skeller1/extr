# this is the router of Extr for EXT Direct, implemented as rack middleware
#Rails.ProjectsController.getChildProject(1,function(r,e){
#alert(r);
#});
#Rails.ProjectsController.getChildProject(2,function(r,e){
#alert(r);
#});
#Rails.ProjectsController.getChildProject(3,function(r,e){
#alert(r);
#});

module Extr

 class Router
  def initialize(app, router_path)
   @app = app
   @router_path = router_path
  end

  def call(env)
   @env = env
   if ext_direct_request?
    body = []
    if form_data?
     r = ExtDirectFormRequest.new(env)
     p "form post"
     #todo implement form_posts
    else
     p "json post"
     @env['HTTP_ACCEPT'] = "application/json"
     r = ExtDirectJsonRequest.new(@env)
     r.transactions.each do |t|
      p t.request.class
      body << (t.model_transaction? ? invoke_model_method(t) : invoke_controller_method(t))
     end
    end
    [200, { "Content-Type" => "application/json"}, ["#{body.to_json}"]]
   else
    @app.call(env)
   end
  end

  private

  def invoke_model_method(t)
   p "invoke model"
   unless t.data.nil?
    return_val = t.action.constantize.send(t.method)
    #return_val = action.constantize.send(method, *normalize_params_for(action,parameters))
   else
    return_val = t.action.constantize.send(t.method)
   end
  end

  def invoke_controller_method(t)

   result = {
    'type'    =>    'rpc',
    'tid'     =>    t.tid,
    'action'  =>    t.action,
    'method'  =>    t.method,
    'result' => ""
   }

   controller = Config.get_controller_path(t.action)
   p Config.controller_path

   begin

    status,headers,response = controller.action(t.method).call(@env)
    #status,headers,response = @app.call(controller_request_env)
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
     result["result"] = ""
    end
     result
   end

  end


  def ext_direct_request?
   @env["PATH_INFO"].match("^#{@router_path}") && @env['REQUEST_METHOD']== "POST"
   #todo and params exist
  end

  def form_data?
   @env['rack.request.form_hash'] ? true : false
  end

 end
end

