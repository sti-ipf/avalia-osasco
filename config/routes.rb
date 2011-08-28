IpfOsascoAvaliacao2011::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => 'evaluation#index'
  match "authenticate", :to => 'evaluation#authenticate'
  match "confirm", :to => 'evaluation#confirm'
  match "identify", :to => 'evaluation#identify'
  match "instructions", :to => 'evaluation#instructions'
  match "answerdimension", :to => 'evaluation#answerdimension'
  match "review", :to => 'evaluation#review'
  match "checkreview", :to => 'evaluation#checkreview'
  match "save", :to => 'evaluation#save'
  match "presence_list", :to => 'evaluation#presence_list'
  match "save_presence_list", :to => 'evaluation#save_presence_list'

  match "passwords/generate_all_letters", :to => 'passwords#generate_all_letters'
  match "passwords/generate_all_passwords", :to => 'passwords#generate_all_passwords'
  match "admin/passwords/:id/download_letter", :to => 'admin_passwords#download_letter'

end

