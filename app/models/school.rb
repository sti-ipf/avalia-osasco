class School < ActiveRecord::Base
  belongs_to :service_level
  has_many :passwords
  has_many :answers
  has_many :practices
  has_many :dimension_statuses
  has_many :presence

end
