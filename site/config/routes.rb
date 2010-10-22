ActionController::Routing::Routes.draw do |map|
  map.resources :gems
  map.root :controller => 'gems', :action => 'index'
end
