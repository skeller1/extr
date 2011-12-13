# ExtR


__UNDER DEVELOPMENT!!!!! first stable release in begin of January 2012git://github.com/skeller1/extr.git__


__An open source Ruby on Rails 3.1.x engine for using ExtDirect in Rails Applications.__

ExtR is an Rails 3.1.x compatible implementation of the [Ext.Direct API specification](http://bla.de) from the famous [Sencha Ext Js Framework](http://www.sencha.com/). If you want to write UI's with the power of Ruby have a look at [Netzke](http://netzke.org/), the brilliant Sencha Ext JS and Ruby on Rails component framework.

The Ext.Direct API allows you to call serverside methods from the client side. This makes the development of complex UI's' easier and more efficient.


## Requirements

* [Rails 3.1.x](http://github.com/rails/rails


## Install

Add this line to your applications `Gemfile`

    gem 'extr', :git => "git://github.com/skeller1/extr.git"

Next run

    bundle install



## Usage

1.  Make JS und CSS for Sencha Ext Js available

    <!DOCTYPE html>
    <html>
        <head>
            <title>Extr</title>
            <%= csrf_meta_tags %>
            <%= ext_base_tag %>
            <%= ext %>
            <%= ext_direct_provider "Rails" %>
        </head>
        <body>
            <%= yield %>
        </body>
    </html>


2.  Make your controller directable by including Extr::DirectController

    class ProjectsController < ApplicationController

     include Extr::DirectController

     #...

    end


3.  Use the direct class method to register the directable controller actions


    class ProjectsController < ApplicationController

     include Extr::DirectController

     direct {:get_child_project => 3, :get_parent_project => 1}



     def get_child_project
      #...
     end

     def get_parent_project
      #...
     end

    end


    The number 3 and 1 specifies the amount of params that can passed


  #skip_before_filter :verify_authenticity_token

  direct({:getChildProject => 1, :getChildNodes => 1}, "Mike")


  def getChildProject
    render :json => {:name => "Project#{Random.rand(11)}"}.to_json
  end


  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end


If you get an error like

    uninitialized constant Refinery::Pages::Tab

It means your Refinery version isn't new enough. To fix that you need to update the Refinery CMS `Gemfile` line to this

    gem 'refinerycms', '~> 0.9.9'

Then run:

    bundle install
    rake refinery:update


## Features


### Make your controller directable

### Make your models directable

### Use different names for

## TODO

* make

## License

