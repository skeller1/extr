module Extr
  class Engine < Rails::Engine

    initializer "read_ext_config_from_yaml" do |app|

     yaml_path = Rails.root.join("config", "extdirect.yml")
     if File.exists? yaml_path

      YAML.load_file(yaml_path).each do |klass, options|

       action = options["name"] || klass.gsub("_","")
       Config.controller_path[action]=klass.gsub("_","::").to_s

       unless options["methods"].nil?
        options["methods"].stringify_keys!.merge!(DirectController::DEFAULT_METHODS).each do |mtd, mcfg|
         if mcfg.is_a?(Hash)
          Config.controller_config[action] << {'name' => mtd}.merge!(mcfg)
          #Config.controller_config[action] << {'name' => mtd, 'formHandler' => true}.merge!(mcfg)
         else
          Config.controller_config[action] << {'name' => mtd, 'len' => mcfg || 1}
          #Config.controller_config[action] << { 'name' => mtd, 'len' => mcfg || 1, 'formHandler' => true }
         end
        end
       end
      end

     end
    end

  end
end

