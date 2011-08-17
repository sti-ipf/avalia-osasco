class Dimension < ActiveRecord::Base
  belongs_to :service_level
  has_many :indicators
  has_many :practices
  has_many :dimension_statuses
end
