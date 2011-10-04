module Extr
  class AllowedControllers
    def self.matches?(request)
      p request
      
      true#Config.has_controller?()
    end
  end
end

