class Dimension < ActiveRecord::Base
  belongs_to :service_level
  has_many :indicators
  has_many :practices
  has_many :dimension_statuses

  #ServiceLevel.all.each do |sl|
  #  scope sl.name, where(:service_level_id => sl.id)
  #end
end

