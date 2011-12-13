class Typo3::LoginController < ApplicationController


  skip_before_filter :verify_authenticity_token

  
  respond_to :json


  include Extr::DirectController

  direct  "TYPO3_Controller_LoginController",
    :show => 1,
    :logout => 1



  def show
    @skeller = Time.now
    respond_with (@skeller)
  end

  def logout
    
  end

end
