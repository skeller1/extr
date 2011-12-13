require 'test_helper'

class ExtrTest < ActiveSupport::TestCase

  test "assert_extr_core_structure" do
    assert_kind_of Module, Extr
    assert_kind_of String, Extr::Config::ROUTER_PATH
  end

  test "no_ext_direct_request_by_get" do

    assert_match Extr::Config::ROUTER_PATH
    assert_response :missing

  end


end

