class Dimension < ActiveRecord::Base
  belongs_to :service_level
  has_many :indicators
  has_many :practices
  has_many :dimension_statuses

  begin
    ServiceLevel.all.each do |sl|
      scope sl.name, where(:service_level_id => sl.id)
    end
  rescue
  end

  def to_label
    "#{self.number} - #{self.name}"
  end
end

