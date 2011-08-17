class School < ActiveRecord::Base
  belongs_to :service_level
  has_many :passwords
end
