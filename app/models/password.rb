class Password < ActiveRecord::Base
  belongs_to :segment
  belongs_to :school
  belongs_to :service_level
end

