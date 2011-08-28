class Password < ActiveRecord::Base
  belongs_to :segment
  belongs_to :school
  belongs_to :service_level

  begin
    ServiceLevel.all.each do |sl|
      scope sl.name, where(:service_level_id => sl.id)
    end
  rescue
  end

end

