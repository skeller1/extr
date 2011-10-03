Extr::Engine.routes.draw do

end

Rails.application.routes.draw do
  match ':controller-:action/:format'
end

