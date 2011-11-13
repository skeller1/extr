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

 end

end

