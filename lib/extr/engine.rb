module Extr
  class Engine < Rails::Engine

    initializer "read_ext_config_from_yaml" do |app|
     #p app.paths["config/initializers"]
     #p YAML::load(ERB.new(IO.read(app.paths["config/initializers"].first)).result)
     #Rails.application.paths["config/initializers"]
     yaml_path = Rails.root.join("config", "initializers","extdirect.yml")

     if File.exists? yaml_path
      p YAML.load_file(yaml_path)
     end

    end

  end
end

