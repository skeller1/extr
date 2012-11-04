class ProfilsController < ApplicationController
  respond_to :json, :html


  before_filter :show_request



  def show_request
   #p request.env["REQUEST_PATH"]
   #p request.env["PATH_INFO"]
   #p request.env["REQUEST_URI"]
   #p request.env["HTTP_ORIGIN"]
   #p request.env["ORIGINAL_FULLPATH"]
  end

  def getBasicInfo
    render :json => {
      :success => true,
      :data => {
        foo: "bar",
        name: "Test name",
        company: "Test company",
        email: "test@company.com"
      }
    }
  end

  def updateBasicInfo
    render :json => {:success => true}
  end

  def getPhoneInfo
    render :json => {
      :success => true,
      :data => {
        cell: "123-456-789",
        office: "1-800-CALLEXT",
        home: ""
      }
    }
  end

  def getLocationInfo
    render :json => {
      :success => true,
      :data => {
        zip: 33776,
        street: "1234 Test.",
        state: "Testland",
        city: "Test city"
      }
    }
  end
end

