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

  def self.segment_has_more_than_one_service_level(password)
    segment = Segment.find(password.segment_id)
    segment_ids = Segment.all(:conditions => "name = '#{segment.name}'").collect(&:id).join(',')
    total = Password.count(:conditions => "school_id = #{password.school_id} AND segment_id IN (#{segment_ids})")
    total > 1
  end

end

