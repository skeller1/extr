module Extr
  class Config

    ROUTER_PATH = 'extr/direct_router'.freeze

    cattr_accessor :model_config
    cattr_accessor :controller_config
    cattr_accessor :controller_path

    class << self
      def model_config
        @@model_config ||= Hash.new { |hash, key| hash[key] = [] }
      end

      def controller_config
        @@controller_config ||= Hash.new { |hash, key| hash[key] = [] }
      end

      def controller_path
        @@controller_path ||= {}
      end

      def get_controller_path(action)
        controller_path[action]
      end

      private

      def methods_for(action)
        model_config[action].map {|m| m['name']}
      end

    end
  end
end

