module Extr
 class RouterController < ActionController::Base

  protect_from_forgery

  respond_to :html, :json

  def direct

   p request.headers['X-CSRF-Token']

   body = transactions.map(&:response)

   if request.form_data?
    render :inline => "<html><body><textarea>#{body.to_json}</textarea></body></html>", :content_type => 'text/html'
   else
    render :json => body ||= ""
   end
  end

 private

  def transactions
   @transactions ||= collect_transactions
  end

  def collect_transactions
   arr = []
   raw_http_params.each do |p|
    if request.form_data?
      t = Transaction.new(request,
                          p[:extAction],
                          p[:extMethod],
                          p[:extTID],
                          p[:data],
                          p[:extUpload]
      )
    else
      t = Transaction.new(request,
                          p[:action],
                          p[:method],
                          p[:tid],
                          p[:data],
                          false
      )
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

 protected

  def handle_unverified_request
   reset_session
   body = []
   transactions.each do |t|
    body << {
      'type'    => 'exception',
      'tid'     => t.tid,
      'action'  => t.action,
      'method'  => t.method,
      'result'  => "WARNING: Can't verify CSRF token authenticity"
    }
   end
   render :json => body

  end


 end

end

