class ApplicationController < ActionController::Base

  protect_from_forgery

  respond_to :json

  def action1
    render :json => {:Date => Time.now}
  end


  def action2

  end

  def action3
    render :json => {:Date => Time.now}
  end

end

