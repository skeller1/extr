module Extr
 autoload "Config", 			'extr/config'
 autoload "ExtDirectJsonRequest",	'extr/request/json_request'
 autoload "Transaction",			'extr/transaction'
 autoload "Router", 			'extr/router'
 autoload "AllowedControllers",		'extr/allowed_controllers'
 
 require 'extr/direct_controller'
 require 'extr/acts_as_direct'
end

require "extr/engine"

