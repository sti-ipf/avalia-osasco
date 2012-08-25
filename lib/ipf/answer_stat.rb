module IPF
	class AnswerStat
		def self.generate
			levels = ServiceLevel.all
			levels.each do |level|
        level.segments.each do |segment|
          level.schools.each do |school|
            stat = EvaluationAnswerStat.first(:conditions => {
              :service_level_id => level.id, 
              :segment_id => segment.id, 
              :school_id => school.id
              })
            if stat.blank?
      	      EvaluationAnswerStat.create(
                :service_level => level, 
                :segment => segment, 
                :school => school, 
                :started_to_answer => false)
            end
          end
        end
      end
		end
	end
end

