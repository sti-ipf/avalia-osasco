ActiveAdmin.register Dimension do
  menu :parent => "Avaliação", :priority => 4
  filter :number
  filter :name

  begin
    first = false
    ServiceLevel.all.each do |sl|
      if(!first)
        scope sl.name, :default => true
        first = true
      else
        scope sl.name
      end
    end
  rescue
  end

  action_item do
    link_to "Importar", import_dimensions_path
  end

  index do
    column :number
    column :name
    default_actions
  end

end

