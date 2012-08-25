ActiveAdmin.register ServiceLevel do
  menu :parent => "Avaliação", :priority => 1
  filter :name

  index do
    column :name
    default_actions
  end

  action_item do
    link_to "Importar", import_service_levels_path
  end
end

