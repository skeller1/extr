Extr::Engine.routes.draw do

  #constraints(ActiveDirect::AllowedControllers) do
    match ':controller-:action/:format'
  #end

end

