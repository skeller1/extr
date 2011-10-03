class Project < ActiveRecord::Base

  acts_as_direct  :root_nodes => 3, :upload => {:len => 2, :formHandler => true}

  def root_nodes

  end

  def upload

  end

end

