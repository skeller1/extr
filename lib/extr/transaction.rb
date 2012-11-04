module Extr

 class Transaction

  include ActiveModel::Validations

  validates :action, :presence => true
  validates :method, :presence => true
  validates :tid, :presence => true, :numericality => {:greater_than => 0}

  attr_reader :request, :action, :method, :data, :tid, :upload

  def initialize(request, action, method, tid, data, upload)
   @request = request
   @action = action
   @method = method
   @data = data
   @tid = tid
   @upload = upload
  end


  def uploadable?
   @upload ? true : false
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

    controller_klass = Config.get_controller_path(self.action).constantize

    unless controller_klass.mimes_for_respond_to.key?(Mime::JSON.symbol)
     raise "For supporting the rails way define at least respond_to :json in that controller: #{controller_klass}"
    end

    unless self.request.form_data?
     ext_params = HashWithIndifferentAccess.new
     ext_params[:data] = self.data
     self.request.env["action_dispatch.request.parameters"] = ext_params
    end

    self.request.env["REQUEST_PATH"] = controller_klass.controller_path
    self.request.env["PATH_INFO"] = controller_klass.controller_path
    self.request.env["REQUEST_URI"] = controller_klass.controller_path
    self.request.env["HTTP_ORIGIN"] = controller_klass.controller_path
    self.request.env["ORIGINAL_FULLPATH"] = controller_klass.controller_path

    body = controller_klass.action(self.method).call(self.request.env).to_a.last.body
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

 end

end

