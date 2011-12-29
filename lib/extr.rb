module Extr
 autoload "Config", 			        'extr/config'
 autoload "ExtDirectJsonRequest",	'extr/request/json_request'
 autoload "Transaction",			    'extr/transaction'

 require 'extr/direct_controller'
 require 'extr/acts_as_direct'
end

require "extr/engine"

