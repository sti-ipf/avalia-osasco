class Practice < ActiveRecord::Base
  belongs_to :segment
  belongs_to :school
  belongs_to :dimension
end
