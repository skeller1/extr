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

  def model_transaction?
   @model_transaction
  end

  def response
   model_transaction? ? invoke_model_method : invoke_controller_method
  end

  private
#=begin
  def invoke_model_method
   unless self.data.nil?
    return_val = self.action.constantize.send(self.method)
    #return_val = action.constantize.send(method, *normalize_params_for(action,parameters))
   else
    return_val = self.action.constantize.send(self.method)
   end
  end

  def invoke_controller_method
   #prepare controller invoke
   controller_path = Config.get_controller_path(self.action)
   controller_request_env = self.request.env.dup  
   controller_request_env["PATH_INFO"] = "extr/#{controller_path}-#{self.method}/json"
   controller_request_env["REQUEST_URI"] = "extr/#{controller_path}-#{self.method}/json"
   
   #start controller invoke
   begin
    #controller.constantize.action(method).call
    status,headers,response=ProjectsController.action(self.method).call(controller_request_env)
   rescue => ex
    Rails.logger.error ex.message
    Rails.logger.error ex.backtrace
   ensure
    return []
   end
  end
#=end
   
 end

end
