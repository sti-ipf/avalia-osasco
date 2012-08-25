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
  match "gabarito", :to => 'evaluation#evaluation_template', :as => 'template'

  match "passwords/generate_all_letters", :to => 'passwords#generate_all_letters'
  match "passwords/generate_creche_conveniadas_letters", :to => 'passwords#generate_creche_conveniadas_letters'
  match "passwords/generate_all_passwords", :to => 'passwords#generate_all_passwords'
  match "admin/passwords/:id/download_letter", :to => 'admin_passwords#download_letter'

  match "mapa", :to => 'complex_queries#map_table', :as => 'map'
  match "sistema/respostas/gerar_estatisticas", :to => 'system#generate_answer_stats', :as => 'generate_answer_stats'
  match "sistema/senhas/gerar", :to => 'system#generate_passwords', :as => 'generate_passwords'
  match "sistema/instrumental/importar", :to => 'system#import_instrument', :as => 'import_instrument'
  match "sistema/niveis_de_servico/importar", :to => 'system#import_service_levels', :as => 'import_service_levels'
  match "sistema/escolas/importar", :to => 'system#import_schools', :as => 'import_schools'
  match "sistema/dimensoes/importar", :to => 'system#import_dimensions', :as => 'import_dimensions'
  match "sistema/segmentos/importar", :to => 'system#import_segments', :as => 'import_segments'
  match "sistema/indicadores/importar", :to => 'system#import_indicators', :as => 'import_indicators'
  
  
  

  resources :evaluation do
    get :autocomplete_school_name, :on => :collection
  end
end

