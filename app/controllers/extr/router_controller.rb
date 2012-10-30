module Extr
 class RouterController < ActionController::Base

  respond_to :json

  def direct
   body = transactions.map(&:response)
   render :json => body ||= ""
  end


  private

  def transactions
   @transactions ||= collect_transactions
  end

  def collect_transactions
   arr = []
   raw_http_params.each do |p|
    if request.form_data?
      t = Transaction.new(request, p.delete(:extAction), p.delete(:extMethod), p.delete(:extTID), p.delete(:data))
    else
      t = Transaction.new(request, p[:action], p[:method], p[:tid], p[:data])
    end
    arr << t if t.valid?
   end
   return arr
  end

  def raw_http_params
   parse request.env["action_dispatch.request.request_parameters"]
  end

  def parse(data)
   return (data["_json"]) ? data["_json"] : [data]
  end

 end

end

