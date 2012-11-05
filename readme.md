[![Dependency Status](https://gemnasium.com/skeller1/extr.png)](https://gemnasium.com/skeller1/extr)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/skeller1/extr)

# __ExtR__


__An open source Ruby on Rails 3.x engine for using ExtDirect in Rails Applications.__

ExtR is an Rails 3.x compatible implementation of the [Ext.Direct API specification](http://www.sencha.com/products/extjs/extdirect) from the famous [Sencha Ext Js Framework](http://www.sencha.com/). If you want to write Ext Js UI's with the power of Ruby have a look at [Netzke](http://netzke.org/), the brilliant Sencha Ext JS and Ruby on Rails component framework.


## Intension

The Ext.Direct API allows you to call serverside methods within the client side (Javascript). This makes the development of complex UI's' easier and more efficient. Have a look:


Normal Ajax call with JQuery

    $.ajax({
     url: "projects",
     context: document.body,
     success: function(){
      alert("Got all projects");
     }
    });


Ext Js call with Ext.Direct API

    Rails.Projects.all(function(r,e){
        alert("Got all projects");
    })


## Requirements
* ExtJS
* [Rails 3.x](http://github.com/rails/rails)


## Install

Add this line to your applications `Gemfile`

    gem 'extr'

Next run

    bundle install

Ready to start


## Usage

1.  __Prepare Ext JS dependencies__

    This gem doesn't provide any up to date ExtJS or ExtDirect components (Javascript or CSS files). It's up to you to make the neccessary files available in your layout file.

   So everybody can feel free to choose the right ExtJS version with or without the power of Rails's Asset Pipeline.

        <!DOCTYPE html>
        <html>
         <head>
          <title>Extr</title>
          <%= csrf_meta_tags %>
          <!-- Previous IMPORT OF JS and CSS FILES for ExtJS and Ext Direct -->
          <%= ext_direct_provider "Rails" %>
         </head>
         <body>
          <%= yield %>
         </body>
        </html>


    In your `application layout file` you have to use the `ext_direct_provider` helper that generates the Ext Direct API Remote Provider Configuration with a specified namespace ( e.g. `Rails`)


2.  __Register your directable controller actions__

    Define your controller configuration in one configuration file (`config/extdirect.yml`):

        ProjectsController:
         methods:
          getChildProject: 3
          getParentProject: 1
         formHandler:
          getUpload: 0
        ApplicationController:
         methods:
          action1: 3
          action2: 1
         formHandler:
          action3: 2
          action4: 1
        Admin_RegistrationController:
         methods:
            ...

        ...

    Namespaced controllers must be written with an underscore (e.g. `Admin_RegistrationController`)


3. __Set Response format for the controller__

    Your directable controllers must render json: `respond_to :json`:

        class ProjectsController < ApplicationController

         respond_to :json #optional, action must produce json output


         def get_child_project
          @data = ...

          # render :json direct in your controller
          render :json => @data
         end

         def get_parent_project
          @data = ...
          # use own get_parent_project.json.erb view for json response
          respond_with @data
         end

        end



4. __Call controller actions on the client side__

    Create a Rails route to your new view that is a startpoint for your new Ext Js UI. Make sure that you load it with your `application.html.erb` layout file, that includes all the Ext Js and Ext Direct files.

    In your written JS files or in Firebug (Javascript console) you can call your `ProjectsController` actions:

        Rails.ProjectsController.get_child_project(current_project,function(result,e){
         alert(result);
        })



    Executing this script many times only results in one Rails request to the implemented Ext Js Direct Router controller.

## Additional Features


### Use different names for controller names
By using 3rd Party Ext Js scripts (or other circumstances) it would be nice using other controller names in your Rails app. So you can use 3rd party JS Files without any changes using the `name:` key in your yaml config:

        ProjectsController:
          name: MyCustomController
          methods:
            getChildProject: 2
            getOtherProject: 3
        ApplicationController:
          methods:
            action1: 1
            action2: 3
          name: SuperApplicationController
        ...


It's now possible to use this Ext Direct controller name in your JS scripts:

    Rails.SuperApplicationController.action1(current_project,function(result,e){
     alert(result);
    })

## License
Extr is released under the [MIT License](http://www.opensource.org/licenses/MIT).

