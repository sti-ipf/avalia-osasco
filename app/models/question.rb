class Question < ActiveRecord::Base
  has_many :question_texts
  belongs_to :service_level
  belongs_to :indicator

  accepts_nested_attributes_for :question_texts, :reject_if => lambda { |a| a[:text].blank? }, :allow_destroy => true

  def self.create_or_find(number, service_level, indicator_id)
  	question = Question.first(:conditions => "number = #{number} AND service_level_id = #{service_level} AND indicator_id = #{indicator_id}")
  	if question.nil?
  		return Question.create(:number => number, :service_level_id => service_level, :indicator_id => indicator_id)
  	else
  		return question
  	end
  end

end
