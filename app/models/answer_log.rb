class AnswerLog < ActiveRecord::Base
	belongs_to :service_level
	belongs_to :school
	belongs_to :segment
	belongs_to :dimension

	begin
    ServiceLevel.all.each do |sl|
      scope sl.name, where(:service_level_id => sl.id)
    end
  rescue
  end

end
