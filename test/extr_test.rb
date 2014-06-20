require 'test_helper'

class ExtrTest < ActiveSupport::TestCase
=begin
  #include Rack::Test::Methods

  #def call_rails(env_params={})

   @request = ActionDispatch::TestRequest.new(env_params)
   @request['REQUEST_METHOD'] = "POST"
   @request.host = "localhost"
   @request.port = 3000
   @request.request_uri = Extr::Config::ROUTER_PATH
   @request['PATH_INFO'] = Extr::Config::ROUTER_PATH
   @request['HTTP_ACCEPT'] = 'application/json'

   #p @response = Dummy::Application.routes.call(@request.env)

   #@response = (env.delete(:app) || Dummy::Application.routes).call(env).to_a

  end

  test "assert_extr_core_structure" do
    assert_kind_of Module, Extr
    assert_kind_of String, Extr::Config::ROUTER_PATH
  end

  test "no_ext_direct_request_by_get" do
    call_rails
    test_body = '{"bar":"foo"}'
    callback = 'foo'
    app = lambda { |env| [200, {'Content-Type' => 'application/json'}, [test_body]] }
    #body = Extr::Router.new(app, Extr::Config::ROUTER_PATH).call(@request).to_a
    #p body
    #p body #body.should.equal ["#{callback}(#{test_body})"]
    #call_rails
    #assert_equal 404, @response.first
    #assert_match Extr::Config::ROUTER_PATH
    #assert_response :missing

  end

  test "make post" do
    #get "#{Extr::Config::ROUTER_PATH}"
    #get "#{Extr::Config::ROUTER_PATH}"
    #assert_response 404
  end

=end

end

