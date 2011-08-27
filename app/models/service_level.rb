class ServiceLevel < ActiveRecord::Base
  #has_many :service_level_schools
  #has_many :schools, :through => :service_level_schools
  has_and_belongs_to_many :schools
  has_many :dimensions
  has_many :segments
  has_many :questions
  has_many :passwords
end

