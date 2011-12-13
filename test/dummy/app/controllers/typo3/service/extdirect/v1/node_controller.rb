class Typo3::Service::Extdirect::V1::NodeController < ApplicationController

  skip_before_filter :verify_authenticity_token

  include Extr::DirectController

  direct  "TYPO3_Service_ExtDirect_V1_Controller_NodeController",
    :getChildNodesForTree => 2,
    :getChildNodes => 2


  respond_to :json


  def getChildNodesForTree
    @unpublished=0
    respond_with(@unpublished)
  end

  def getChildNodes
    #render :json => Time.now
    #@unpublished=0
    #respond_with(@unpublished
  end

end
