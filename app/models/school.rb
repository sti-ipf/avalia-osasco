class School < ActiveRecord::Base
  has_and_belongs_to_many :service_levels
  has_many :passwords
  has_many :answers
  has_many :practices
  has_many :dimension_statuses
  has_many :presence
  has_many :presence
  has_many :evaluation_answer_stats
  has_many :answer_logs
  has_and_belongs_to_many :groups

  begin
    ServiceLevel.all.each do |sl|
      scope sl.name, School.joins(:service_levels).where("service_levels.id = ?", sl.id)
    end
  rescue
  end

end

