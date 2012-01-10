class Question < ActiveRecord::Base
  has_many :question_texts
  belongs_to :service_level
  belongs_to :indicator

  def self.create_or_find(number, service_level, indicator)
  	question = Question.first(:conditions => "number = #{number} AND service_level_id = #{service_level} AND indicator_id = #{indicator}")
  	if question.nil?
  		return Question.create(:number => number, :service_level_id => service_level, :indicator_id => indicator)
  	else
  		return question
  	end
  end

end
