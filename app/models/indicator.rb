class Indicator < ActiveRecord::Base
  belongs_to :dimension
  has_many :questions

  if self.table_exists?
    puts "tabls exists"
    ServiceLevel.all.each do |sl|
      scope sl.name, Segment.joins(:dimension => :service_level).where("service_levels.id = #{sl.id}")
    end
  end

end

