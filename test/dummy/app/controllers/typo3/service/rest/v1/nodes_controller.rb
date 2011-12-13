class Typo3::Service::Rest::V1::NodesController < ApplicationController

  layout false

 #skip_before_filter :verify_authenticity_token

  #include ActiveDirect::DirectController

  #direct  "TYPO3_Service_ExtDirect_V1_Controller_WorkspaceController",
  #  :getStatus => 1,
  #  :getUnpublishedNodes => 1


  #respond_to :json


  def show
    
  end

  
end