# desc "Explaining what the task does"
# task :extr do
#   # Task goes here
# end

namespace :routes do

  desc "List routing configuration for ext direct"
  task :extr => :environment do
    
  	Extr::Config.controller_config.sort.each do |ns|
      js_calls, path_calls = [],[]
  		namespace = ns.reverse!.pop
  		puts "Extr routing for #{namespace} namespace:"
  		ns.sort.each do |action|
       action.sort.each do |k,v|
  		  v.each do |method|

  		   params_list=[]
  		   method['len'].times.collect do |i|
  		    params_list << "p#{i+1}"
  		   end
  		   params_list << "callback"
  		   js_calls << "#{namespace}.#{k}.#{method['name']}(#{params_list.join(",")})"
         path_calls << "#{Extr::Config.controller_path[k].constantize.controller_path}##{method['name']}"
  		  
        end
  		 end
      end
      js_width = js_calls.map{ |js| js.length }.max
      path_calls.reverse!
      js_calls.each do |js|
        puts "#{js.ljust(js_width)} #{path_calls.pop}"
      end
      puts
  	end

  #end task
  end

end