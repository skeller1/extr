class ApplicationController < ActionController::Base

  protect_from_forgery

  include Extr::DirectController

  def makeone
   @time = {:month => "Data was #{params[:data].class} on #{Time.now}"}
   render :json => @time
  end

end

