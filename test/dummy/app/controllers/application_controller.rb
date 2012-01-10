class ApplicationController < ActionController::Base

  protect_from_forgery

  include Extr::DirectController

  #extdirect :methods => {:makeone => 1}

  #def makeone
  # @time = {:month => "Data was #{params[:data].class} on #{Time.now}"}
  # render :json => @time
  #end

end

