module Extr
 # Extr::RouterController is a standard Rails Action Controller that receives all incoming ExtJS requests
 # (included validation of the transaction) and delegate them to the specified controller actions inside your Rails application.
 #
 #
 #
 #
 class RouterController < ActionController::Base

  protect_from_forgery

  respond_to :html, :json

  def direct
   body = transactions.map(&:response)

   if request.form_data? and extjs_form_with_upload
    render :inline => "<html><body><textarea>#{body.to_json}</textarea></body></html>", :content_type => 'text/html'
   else
    render :json => body ||= ""
   end
  end

 private

  def extjs_form_with_upload
   params.select{|k,v| v.class == ActionDispatch::Http::UploadedFile}.any?
  end

  def transactions
   @transactions ||= collect_transactions
  end

  def collect_transactions
   arr = []
   raw_http_params.each do |p|
     t = Transaction.new(request,
                          p[:extAction] || p[:action],
                          p[:extMethod] || p[:method],
                          p[:extTID] || p[:tid],
                          p[:data],
                          p[:extUpload] || false
     )
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

