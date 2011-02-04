

Survey.all.each do |survey| 
  survey.questions.each do |q|
    n = q.number.split('.')[0..1].join('.')
    p n
    ind = Indicator.all(:conditions => "service_level_id = #{survey.service_level.id} AND segment_id = #{survey.segment.id} AND number = #{n}").first
    q.indicator_id = ind.nil? ? nil : ind.id
    q.save!
  end
end 
  
