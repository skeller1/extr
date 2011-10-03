module Extr
  module DirectController
    DEFAULT_METHODS = {}

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      def direct(name=false, direct_methods={})
        if name
          Config.controller_path[name]=self.controller_path
        else
          Config.controller_path[self.to_s]=self.controller_path
        end


        action = name ||= self.to_s

        Config.controller_config[action].clear
        direct_methods.stringify_keys!.merge!(DEFAULT_METHODS).each do |mtd, mcfg|
          if mcfg.is_a?(Hash)
            Config.controller_config[action] << {'name' => mtd}.merge!(mcfg)
          else
            Config.controller_config[action] << { 'name' => mtd, 'len' => mcfg }
          end
        end
      rescue => ex
        Rails.logger.error ex.message
        Rails.logger.error ex.backtrace
      end
     end
  end
end

