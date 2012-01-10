
QuestionText.all.each do |q|
  number = q.text.split(' ').first
  dimension_number = number.split('.').first
  q.dimension_number = dimension_number.to_i
  q.question_number = number

  question = q.question

  dimension = Dimension.first(:conditions => "service_level_id = #{question.service_level_id} AND number = #{dimension_number}")
  q.dimension_id = dimension.id

  q.save
end

