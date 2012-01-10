ActiveAdmin.register Indicator do
  menu :parent => "Avaliação", :priority => 5
  filter :dimension
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

  index do
    column :number
    column :name
    column :dimension
    default_actions
  end

end

