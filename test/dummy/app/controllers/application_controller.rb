class ApplicationController < ActionController::Base
  protect_from_forgery

  include Extr::DirectController

  direct({:makeone => 1, :maketwo => 2})

end

