module Extr

 class Transaction

  include ActiveModel::Validations

  validates :action, :presence => true
  validates :method, :presence => true
  validates :tid, :presence => true, :numericality => {:greater_than => 0}


  attr_reader :request, :action, :method, :data, :tid

  def initialize(request, action, method, data , tid)
   @request = request
   @action = action
   @method = method
   @data = data
   @tid = tid
   @model_transaction = Config.has_model?(action)
  end


  def response
   model_transaction? ? invoke_model_method : invoke_controller_method
  end

  def model_transaction?
   @model_transaction
  end

  def invoke_model_method
   p "invoke model"
   unless self.data.nil?
    return_val = self.action.constantize.send(self.method)
    #return_val = action.constantize.send(method, *normalize_params_for(action,parameters))
   else
    return_val = self.action.constantize.send(self.method)
   end
  end

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
    p body = controller.constantize.action(self.method).call(request.env).to_a.last.body
    ext['result'] = ActiveSupport::JSON.decode(body) unless body.empty?

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

 end

end

