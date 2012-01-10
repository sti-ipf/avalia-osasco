IpfOsascoAvaliacao2011::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => 'evaluation#index'
  match "autenticar", :to => 'evaluation#authenticate'
  match "confirmar", :to => 'evaluation#confirm'
  match "identificar", :to => 'evaluation#identify'
  match "instrucoes", :to => 'evaluation#instructions'
  match "responder_dimensao", :to => 'evaluation#answerdimension'
  match "revisar", :to => 'evaluation#review'
  match "validar_revisao", :to => 'evaluation#checkreview'
  match "salvar", :to => 'evaluation#save'
  match "lista_presenca", :to => 'evaluation#presence_list'
  match "salvar_lista_presenca", :to => 'evaluation#save_presence_list'

  match "passwords/generate_all_letters", :to => 'passwords#generate_all_letters'
  match "passwords/generate_creche_conveniadas_letters", :to => 'passwords#generate_creche_conveniadas_letters'
  match "passwords/generate_all_passwords", :to => 'passwords#generate_all_passwords'
  match "admin/passwords/:id/download_letter", :to => 'admin_passwords#download_letter'

  match "mapa", :to => 'complex_queries#map_table'

  resources :evaluation do
    get :autocomplete_school_name, :on => :collection
  end
end

