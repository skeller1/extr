class ApplicationController < ActionController::Base

  protect_from_forgery

  respond_to :json

  def action1
    render :json => {:Date => Time.now}
  end


  def action2
      render :inline => "#{request.inspect}"
  end

  def action3
    render :json => {:success => true, :date => Time.now, :fileContents => 'ddd' }
  end


end

