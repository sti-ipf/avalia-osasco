class IndicatorsParty < ActiveRecord::Base
  has_many :indicators
  belongs_to :dimension
  belongs_to :service_level
end
