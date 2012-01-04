module Extr

 class ExtDirectJsonRequest < ActionDispatch::Request

  def transactions
   @transactions ||= collect_transactions
  end

  private

  def collect_transactions
    arr = []
    transaction_params.each_with_index do |req, i|
     t = Transaction.new(self, req['action'], req['method'], req['data'], req['tid'])
     arr << t if t.valid?
    end
    return arr
  end

  def transaction_params
   return (params["_json"]) ? params["_json"] : [params]
  end

 end

end

