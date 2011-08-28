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

end

