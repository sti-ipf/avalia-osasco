class EvaluationAnswerStat < ActiveRecord::Base
	belongs_to :service_level
	belongs_to :segment
	belongs_to :school
	belongs_to :dimension

	begin
    ServiceLevel.all.each do |sl|
      scope sl.name, where(:service_level_id => sl.id)
    end
  rescue
  end

  def started_to_answer_to_s
  	if self.started_to_answer
  	  'Sim'
  	else
  	  'Não'
  	end
  end

end
