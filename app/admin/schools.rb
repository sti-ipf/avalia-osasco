ActiveAdmin.register School do
  menu :parent => "Avaliação", :priority => 2
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


  index do
    column :name
    default_actions
  end

  form do |f|
    f.inputs "Nome" do
      f.input :name
      f.input :report_name
    end
    f.inputs "Níveis de serviço" do
      f.input :service_levels, :as => :check_boxes
    end
    f.buttons
  end

  show do |s|
    attributes_table do
      row :name
      row :report_name
      row :service_levels do
        (s.service_levels.map{ |p| p.name }).join(', ')
      end
    end
    active_admin_comments
  end

end

