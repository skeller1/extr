module Extr
 module DirectController
  DEFAULT_METHODS = {}

  def self.included(base)
   base.extend ClassMethods
  end

  module ClassMethods

   def extdirect(*methods)
     options = methods.extract_options!
     action = options.delete(:name) || self.gsub(":","")
     Config.controller_path[action]=self.to_s
     Config.controller_config[action].clear
     options.delete(:methods).stringify_keys!.merge!(DEFAULT_METHODS).each do |mtd, mcfg|
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

