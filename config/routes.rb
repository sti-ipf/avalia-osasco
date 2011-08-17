IpfOsascoAvaliacao2011::Application.routes.draw do |map|
  map.root :controller => 'evaluation', :action => 'index'
  map.authenticate "authenticate", :controller => 'evaluation', :action => 'authenticate'
  map.confirm "confirm", :controller => 'evaluation', :action => 'confirm'
  map.identify "identify", :controller => 'evaluation', :action => 'identify'
  map.instructions "instructions", :controller => 'evaluation', :action => 'instructions'
  map.answerdimension "answerdimension", :controller => 'evaluation', :action => 'answerdimension'
  map.review "review", :controller => 'evaluation', :action => 'review'
  map.save "checkreview", :controller => 'evaluation', :action => 'checkreview'
end
