# desc "Explaining what the task does"
# task :extr do
#   # Task goes here
# end

namespace :routes do

  desc "List routing configuration for ext direct"
  task :extr => :environment do
    p Extr::Config.controller_config
    p Extr::Config.controller_path
  end

end

