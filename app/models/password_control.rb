class PasswordControl < ActiveRecord::Base
  belongs_to :school
  belongs_to :service_level
  belongs_to :segment
end
