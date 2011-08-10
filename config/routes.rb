IpfOsascoAvaliacao2011::Application.routes.draw do |map|
  map.root :controller => 'flow', :action => 'index'
  map.authenticate "authenticate", :controller => 'flow', :action => 'authenticate'
  map.confirm "confirm", :controller => 'flow', :action => 'confirm'
  map.identify "identify", :controller => 'flow', :action => 'identify'
  map.instructions "instructions", :controller => 'flow', :action => 'instructions'
  map.answerdimension "answerdimension", :controller => 'flow', :action => 'answerdimension'
  map.review "review", :controller => 'flow', :action => 'review'
  map.save "checkreview", :controller => 'flow', :action => 'checkreview'
end
