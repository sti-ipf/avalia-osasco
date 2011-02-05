class IndicatorsParty < ActiveRecord::Base
  has_many :indicators
  belongs_to :dimension
end
