class Typo3::Service::Extdirect::V1::WorkspaceController < ApplicationController

  layout false

  include Extr::DirectController

  direct({
  :getStatus => 1,
  :getUnpublishedNodes => 1
  })

#,"TYPO3_Service_ExtDirect_V1_Controller_WorkspaceController"

  respond_to :json


  def getUnpublishedNodes
    @unpublished=Random.rand(99)
    respond_with(@unpublished)
  end


  def getStatus
    @unpublished=Random.rand(99)
    respond_with(@unpublished)
  end

end

