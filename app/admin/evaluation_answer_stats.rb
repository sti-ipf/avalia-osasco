ActiveAdmin.register EvaluationAnswerStat do
	menu :parent => "Avaliação", :priority => 1

  filter :school
  filter :started_to_answer, :as => :select, :collection => proc {[['Sim', 1], ['Não', 0]]}
  filter :started_at
  filter :finished_at

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
	  column :segment, :sortable => :segment_id
	  column :school, :sortable => :school_id
	  column :dimension, :sortable => :dimension_id
	  column :started_to_answer, :started_to_answer_to_s, :sortable => :started_to_answer
	  column :started_at
	  column :finished_at
	  column :updated_at
  end
end
