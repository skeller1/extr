Extr::Engine.routes.draw do

end

Rails.application.routes.draw do
    match 'extr/:controller-:action/:format', :via => :post, :constraints => Extr::AllowedControllers
end

