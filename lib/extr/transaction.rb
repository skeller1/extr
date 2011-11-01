module Extr
 
 class Transaction
  
  attr_reader :request, :action, :method, :data, :tid, :transaction_type

  def initialize(request, action, method, data , tid)
   @request = request
   @action = action
   @method = method
   @data = data
   @tid = tid
   
   #@transaction_type = Config.has_model?(action) ? :model : :controller
      

  end

  #def for_model?
  # @transaction_type
  #end

  #def for_controller?
  # @transaction_type
  #end

  def build_request
  
  end

  def build_esponse
	#\TYPO3\ExtJS\ExtDirect\TransactionResponse();
  end
   
 end

end
