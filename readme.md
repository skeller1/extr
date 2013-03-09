[![Dependency Status](https://gemnasium.com/skeller1/extr.png)](https://gemnasium.com/skeller1/extr)
[![Maintenance Status](http://stillmaintained.com/skeller1/extr.png)](http://stillmaintained.com/skeller1/extr)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/skeller1/extr)
[![endorse](http://api.coderwall.com/skeller1/endorsecount.png)](http://coderwall.com/skeller1)
# __ExtR__


__An open source Ruby on Rails 3.x engine for using Ext.Direct in Rails Applications.__

ExtR is an Rails 3.x compatible implementation of the [Ext.Direct API specification](http://www.sencha.com/products/extjs/extdirect) from the famous [Sencha ExtJS Framework](http://www.sencha.com/). If you want to write ExtJS UI's with the power of Ruby have a look at [Netzke](http://netzke.org/), the brilliant Sencha ExtJS and Ruby on Rails component framework.


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


ExtJS call with Ext.Direct API

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

1.  __Prepare ExtJS dependencies__

    This gem doesn't provide any up to date ExtJS or ExtDirect components (Javascript or CSS files). It's up to you to make the neccessary files available in your layout file.

   So everybody can feel free to choose the right ExtJS version with or without the power of Rails's Asset Pipeline.

        <!DOCTYPE html>
        <html>
         <head>
          <title>Extr</title>
          <%= csrf_meta_tags %>
          <!-- Previous IMPORT OF JS and CSS FILES for ExtJS and Ext.Direct -->
          <%= ext_direct_provider %>
         </head>
         <body>
          <%= yield %>
         </body>
        </html>


    In your `application layout file` you have to use the `ext_direct_provider` helper that generates the Ext.Direct API Remote Provider Configuration for all your specified namespaces ( e.g. `App`)


2.  __Register your directable controller actions__

    Define your controller configuration in one configuration file (`config/extdirect.yml`):

        Rails:
         ProjectsController:
          methods:   #all actions for GET Requests
           getChildProject: 3
           getParentProject: 1
          formHandler: #all actions for FORM POST Requests
           getUpload: 0
         ApplicationController:
          methods:
           action1: 3
           action2: 1
          formHandler:
           action3: 2
           action4: 1
        Testnamespace:
         Admin_RegistrationController:
          methods:
            ...

        ...

    Namespaced controllers must be written with an underscore (e.g. `Admin_RegistrationController`)


3. __Set Response format for the controller__

    Your directable controllers must render json: `respond_to :json`:

        class ProjectsController < ApplicationController

         respond_to :json #action must produce json output


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

    Create a Rails route to your new view that is a startpoint for your new ExtJS UI. Make sure that you load it with your `application.html.erb` layout file, that includes all the Ext Js and Ext Direct files.

    In your written JS files or in Firebug (Javascript console) you can call your `ProjectsController` actions:

        Rails.ProjectsController.get_child_project(current_project,function(result,e){
         alert(result);
        })



    Executing this script many times only results in one Rails request to the implemented ExtJS Direct Router controller.

5. __Rails, ActionController, Ext.Direct and `protect_from_forgery`__

    1. __GET Requests:__
    The Extr application_helper `ext_direct_provider` [adds the form_authenticity_token](https://github.com/skeller1/extr/blob/master/app/helpers/extr/application_helper.rb#L29) to each action used with HTTP GET method. So there's nothing to do.
    
    2. __POST Requests (form posts):__
    If you want to use Ext.Direct with form posts (formHandler actions) you have to add the authenticity token to the base params of your EXT JS panel:
    
            var my_panel = Ext.create('Ext.form.Panel', {
	        baseParams: {
             <%= request_forgery_protection_token %>: '<%= form_authenticity_token %>'
            },
            // other config
	        title: 'My Panel',
	        border: false,
            ...


        [Here's](https://github.com/skeller1/extr/blob/master/test/dummy/app/views/projects/rpcextjs410.html.erb#L27) an example using request protect_from_forgery in an Rails dummy application included in this gem. 
        Any help for adding form_authenticity_token to each form post by default would be nice!!!!



## Additional Features

### Use other name for controller
By using 3rd Party ExtJS scripts (or other circumstances) it would be nice using other controller names in your Rails app. So you can use 3rd party ExtJS Files without any changes using the `name:` key in your yaml config:

	Rails:        
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


It's now possible to use this Ext.Direct controller name in your scripts:

    Rails.SuperApplicationController.action1(current_project,function(result,e){
     alert(result);
    })

### Rake Task

  	rake app:routes:extr
  	rake routes:extr

This rake task allows you to control your extr config defined in `config/extdirect.yml`

## TODO
* Find a way to add authenticity token to each form post component by default (Is it possible???)

## License

Extr is released under the [MIT License](http://www.opensource.org/licenses/MIT).

Copyright (c) 2013 Stephan Keller

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

