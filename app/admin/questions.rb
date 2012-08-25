ActiveAdmin.register Question do
  menu :parent => "Avaliação", :priority => 7


  index do |q|
    column "Indicador - Número" do |question|
      "#{question.indicator.number}.#{question.number}"
    end
    column "Texto" do |question|
      question.question_texts.first.text
    end
    default_actions
  end

  action_item do
    link_to "Importar", import_instrument_path
  end

  form :partial => "form"

  show do |s|
    attributes_table do
      row :id
      row :number
      row :service_level
      row :indicator
      row :question_texts do
        (s.question_texts.map{ |p| p.text }).join(', ')
      end
    end
  end

end


