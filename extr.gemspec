$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "extr/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "extr"
  s.version     = Extr::VERSION
  s.authors     = ["Stephan Keller"]
  s.email       = ["MiStK@gmx.de"]
  s.homepage    = "http://github.com/skeller1/extr/"
  s.summary     = "Extr is a Ext Direct Implementation for Rails 4.x"
  s.description = "ExtR is an Rails 4.x Ext Direct Router with View Helpers and some adjustment abilities."

  s.files = Dir["{app,config,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "readme.md"]
  s.test_files = Dir["test/**/*"]

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency 'rails', '>= 4.0'
  
  s.add_development_dependency 'sqlite3'
end

