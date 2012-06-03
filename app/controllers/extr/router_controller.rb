module Extr
 class RouterController < ActionController::Base

  respond_to :json

  def direct
   #debugger
   if request.form_data?
    #todo implement form_posts
   else
    body = transactions.map(&:response)
   end
   render :json => body ||= ""
  end


  private

  def transactions
   @transactions ||= collect_transactions
  end

  def collect_transactions
   arr = []
   raw_http_params.each do |p|
    t = Transaction.new(request, p[:action], p[:method], p[:data], p[:tid])
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

