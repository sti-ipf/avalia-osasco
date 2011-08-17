class Password < ActiveRecord::Base
  belongs_to :segment
  belongs_to :school
end
