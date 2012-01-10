ActiveAdmin.register ServiceLevel do
  menu :parent => "Avaliação", :priority => 1
  filter :name

  index do
    column :name
    default_actions
  end
end

