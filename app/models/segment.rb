class Segment < ActiveRecord::Base
  belongs_to :service_level
  has_many :question_text
  has_many :passwords
  has_many :answers
  has_many :practices
  has_many :dimension_statuses
  has_many :presence
  has_many :evaluation_answer_stats
  has_many :answer_logs

  begin
    ServiceLevel.all.each do |sl|
      scope sl.name, where("service_level_id = ?", sl.id)
    end
  rescue
  end

end

