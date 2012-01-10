ActiveAdmin.register AnswerLog do
  menu :parent => "Avaliação", :priority => 1

  filter :school
  filter :created_at

  

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
    @schools = School.all
	  column :person
	  column :segment
	  column :school
	  column :dimension
	  column { | answer_log | simple_format(answer_log.questions)}
	  column :created_at
  end

end
