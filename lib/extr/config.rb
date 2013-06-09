module Extr
  class Config

    ROUTER_PATH = '/extr/direct_router'.freeze

    cattr_accessor :controller_config
    cattr_accessor :controller_path

    class << self

      def initialize!
        @@controller_config = Hash.new { |hash, key| hash[key] = {} }
        @@controller_path = {}
      end

    end
  end
end

