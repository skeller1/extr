# __ExtR__


__UNDER DEVELOPMENT!!!!! first stable release in begin of January 2012__

__An open source Ruby on Rails 3.1.x engine for using ExtDirect in Rails Applications.__

ExtR is an Rails 3.1.x compatible implementation of the [Ext.Direct API specification](http://bla.de) from the famous [Sencha Ext Js Framework](http://www.sencha.com/). If you want to write Ext Js UI's with the power of Ruby have a look at [Netzke](http://netzke.org/), the brilliant Sencha Ext JS and Ruby on Rails component framework.






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

    Rails.Projets.all(function(r,e){
        alert("Got all projects");
    })


## Requirements

* [Rails 3.1.x](http://github.com/rails/rails)


## Install

Add this line to your applications `Gemfile`

    gem 'extr', :git => "git://github.com/skeller1/extr.git"

Next run

    bundle install

Ready to start


## Usage

1.  __Prepare Ext JS dependencies__

    Simple integration of the necessary JS and CSS files using the ExtR helper methods in your layout file (`application.html.erb`)

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

    -   __ext_base_tag__: Generate a HTML base tag with the current host and port number)
    -   __ext__: Generate all necessary JS and CSS files for Ext Js
    -   __ext_direct_provider "Rails"__: Generate the Ext.Direct API Remote Provider Configuration with the namespace `Rails`


2.  __Make controller directable__

    Simple including of the `Extr::DirectController` modul at the top of your controller (`projects_controller.rb`)

        class ProjectsController < ApplicationController

         include Extr::DirectController

         #...

        end

    If you want to prepare all Rails controllers being directable, you have to include the module in Rails ApplicationController.


3.  __Register your directable controller actions__

    Use the direct class method to register the directable controller actions

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


    The numbers behind the method names specifies the amount of params that can passed in Javascript before the callback


4. __Start Ext Direct call__

    Create a Rails route to your new view that is a startpoint for your new Ext Js UI. Make sure that you load it with your `application.html.erb` layout file, that includes all necessary Ext Js stuff.

    In your loaded JS or in Firebug (Javascript console) you can call your ProjectsController actions

        Rails.ProjectsController.get_child_project(current_project,function(result,e){
         alert(result);
        })





## Features


### Make your controller directable

### Make your models directable

### Use different names for

## TODO

* make

## License

