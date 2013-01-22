module Extr
  class Engine < Rails::Engine

    initializer "read_ext_config_from_yaml" do |app|

     yaml_path = Rails.root.join("config", "extdirect.yml")
     if File.exists? yaml_path
      YAML.load_file(yaml_path).each do |ns, klasses|
       klasses.each do |klass,options|
	      action = options["name"] || klass.gsub("_","")
	      Config.controller_path[action]=klass.gsub("_","::").to_s
	      Config.controller_config[ns][action]= [] if Config.controller_config[ns][action].nil?	
        keys = ["methods","formHandler"]
	      
        (options.keys & keys).each do |key|
	       unless options[key].nil?
	        options[key].stringify_keys!.each do |mtd, mcfg|
	         method_hash = mcfg.is_a?(Hash) ? {'name' => mtd}.merge!(mcfg) : {'name' => mtd, 'len' => mcfg || 1}
           method_hash[key]= true if key == "formHandler"
           Config.controller_config[ns][action] << method_hash
	        end
	       end
        #END KEY LOOP
        end
       
       end
      end

     #END IF FILE
     end
    end
  
  end
end

