class Survey < ActiveRecord::Base
  belongs_to :segment
  belongs_to :service_level
  has_many :questions

  def self.by_service_level(service_level)
    all :conditions => "service_level_id = #{service_level.id}"
  end

  def questions_by_dimension(dimension)
    Question.all :conditions => "survey_id = #{self.id} AND number LIKE '#{dimension}.%'"
  end

  def questions_by_indicator(dimension,indicator)
    Question.all :conditions => "survey_id = #{self.id} AND number LIKE '#{dimension}.#{indicator}%'"
  end
end
