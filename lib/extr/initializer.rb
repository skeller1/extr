module Extr
  module Initializer

    # NOTE : The following code was stealed from the awesome ThinkingSphinx lib :-)
    #
    # Make sure all models are loaded - without reloading any that
    # ActiveRecord::Base is already aware of (otherwise we start to hit some
    # messy dependencies issues).
    def self.load_models
      return if defined?(Rails) && Rails.configuration.cache_classes

      self.model_directories.each do |base|
        path = "#{Rails.root}/#{base}/**/*.rb"
        Dir[path].each do |file|
          model_name = File.basename(file,'.rb')
          next if model_name.nil?
          begin
            model_name.camelize.constantize
          rescue LoadError
             next
          rescue NameError
            next
          rescue StandardError
            puts "Warning: Error loading #{file}"
          end
        end
      end
    end

     def self.load_controllers

      return if defined?(Rails) && Rails.configuration.cache_classes
        p "Load controllers must be implemented"
      self.controller_directories.each do |base|
        path = "#{Rails.root}/#{base}/**/*.rb"
        Dir[path].each do |file|
          controller_name = File.basename(file,'.rb')
          next if controller_name.nil?
          begin
            controller_name.camelize.constantize
          rescue LoadError
             next
          rescue NameError
            next
          rescue StandardError
            puts "Warning: Error loading #{file}"
          end
        end
      end
    end

    def self.model_directories
      if defined?(Rails.root)
        Rails.application.paths["app/models"]
      else
        []
      end
    end

    def self.controller_directories
      if defined?(Rails.root)
        Rails.application.paths["app/controllers"]
      else
        []
      end
    end

  end
end

if defined?(Rails) && Rails.configuration
  Rails.configuration.after_initialize do
    Extr::Initializer.load_models
    Extr::Initializer.load_controllers
  end
end

