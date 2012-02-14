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
  s.summary     = "Extr is a Ext Direct Implementation for Rails 3.1"
  s.description = "Extr is a Rails 3.1 Ext Direct Router with View Helpers and some adjustment abilities."

  s.files = Dir["{app,config,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "readme.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.1.0"

  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  #s.add_development_dependency 'test-spec', '>= 0.9.0'
  #s.add_development_dependency 'json', '>= 1.1'
end

