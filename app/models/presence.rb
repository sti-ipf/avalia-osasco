class Presence < ActiveRecord::Base
  belongs_to :school
  belongs_to :segment

end
