class Dimension < ActiveRecord::Base
  belongs_to :service_level
  has_many :indicators
end
