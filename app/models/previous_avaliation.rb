class PreviousAvaliation < ActiveRecord::Base
  belongs_to :school
  belongs_to :service_level
  belongs_to :dimension
end
