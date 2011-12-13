# __ExtR__


__UNDER DEVELOPMENT!!!!! first stable release in begin of January 2012__

__An open source Ruby on Rails 3.1.x engine for using ExtDirect in Rails Applications.__

ExtR is an Rails 3.1.x compatible implementation of the [Ext.Direct API specification](http://bla.de) from the famous [Sencha Ext Js Framework](http://www.sencha.com/). If you want to write UI's with the power of Ruby have a look at [Netzke](http://netzke.org/), the brilliant Sencha Ext JS and Ruby on Rails component framework.

The Ext.Direct API allows you to call serverside methods from the client side. This makes the development of complex UI's' easier and more efficient.


## Requirements

* [Rails 3.1.x](http://github.com/rails/rails)


## Install

Add this line to your applications `Gemfile`

    gem 'extr', :git => "git://github.com/skeller1/extr.git"

Next run

    bundle install



## Usage

1.  __Include JS and CSS for Sencha Ext Js available__


    Simple integration using the extr helper methods in example layout file `application.html.erb`

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



2.  __Make your controller directable by including Extr::DirectController__

    Simple including of that modul at the top of your controller `projects_controller.rb`

        class ProjectsController < ApplicationController

         include Extr::DirectController

         #...

        end


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


    The number 3 and 1 specifies the amount of params that can passed in Javascript


## Features


### Make your controller directable

### Make your models directable

### Use different names for

## TODO

* make

## License
