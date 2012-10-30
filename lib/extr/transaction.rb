module Extr

 class Transaction

  include ActiveModel::Validations

  validates :action, :presence => true
  validates :method, :presence => true
  validates :tid, :presence => true, :numericality => {:greater_than => 0}


  attr_reader :request, :action, :method, :data, :tid

  def initialize(request, action, method, tid, data)
   @request = request
   @action = action
   @method = method
   @data = data
   @tid = tid
  end


  def response
   invoke_controller_method
  end

  private

  def invoke_controller_method

   ext = {
    'type'    => 'rpc',
    'tid'     => self.tid,
    'action'  => self.action,
    'method'  => self.method,
    'result'  => ""
   }

   begin

    controller = Config.get_controller_path(self.action)
    token = get_token(controller)

    unless controller.constantize.mimes_for_respond_to.key?(Mime::JSON.symbol)
     if Rails.env.development?
      raise "For supporting the rails way define respond_to :json in your controller"
     end
    end

    ext_params = HashWithIndifferentAccess.new
    ext_params[:method] = self.method
    ext_params[:tid] = self.tid
    ext_params[:data] = "bla"
    ext_params[controller.constantize.request_forgery_protection_token] = token

    self.request.env["action_dispatch.request.parameters"] = ext_params
    body = controller.constantize.action(self.method).call(self.request.env).to_a.last.body
    ext['result'] = body.empty? ? "" : ActiveSupport::JSON.decode(body)

   rescue => e
    if Rails.env.development?
     Rails.logger.error ext['type'] = 'exception'
     Rails.logger.error ext['message'] = e.message
     Rails.logger.error ext['where'] = e.backtrace.join("\n")
    end
   ensure
    return ext
   end

  end

  private

  def get_token(controller)
   request.env["action_dispatch.request.parameters"][controller.constantize.request_forgery_protection_token] ||=   request.env["action_dispatch.request.parameters"][:_json].first[controller.constantize.request_forgery_protection_token]
  end

 end

end

