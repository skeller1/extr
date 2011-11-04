module Extr
  require 'extr/config'
  require 'extr/request/json_request'
  #require 'extr/request/form_request'
  require 'extr/transaction'
  require 'extr/router'
  require 'extr/direct_controller'
  #load model method
  require 'extr/acts_as_direct'
  require 'extr/allowed_controllers'
end

require "extr/engine"

