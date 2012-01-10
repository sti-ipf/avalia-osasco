class DimensionStatus < ActiveRecord::Base
  belongs_to :dimension
  belongs_to :school
  belongs_to :segment
  NOT_STARTED = 0
  IN_PROGRESS = 1
  FINISHED = 2
end
