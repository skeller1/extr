class ApplicationController < ActionController::Base

  protect_from_forgery

  respond_to :html, :json

  def action1
    render :json => {:date => Time.now}
  end


  def action2
      render :inline => "#{request.inspect}"
  end

  def action3
    render :json => {:success => true, :date => Time.now, :fileContents => params[:fileUpload1].nil? ? "": params[:fileUpload1].read}
  end


end

