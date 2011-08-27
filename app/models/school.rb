class School < ActiveRecord::Base
  #has_many :service_level_schools
  #has_many :service_levels, :through => :service_level_schools
  has_and_belongs_to_many :service_levels
  has_many :passwords
  has_many :answers
  has_many :practices
  has_many :dimension_statuses
  has_many :presence

end

