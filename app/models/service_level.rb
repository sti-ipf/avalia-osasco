class ServiceLevel < ActiveRecord::Base
  has_many :schools
  has_many :dimensions
  has_many :segments
  has_many :questions
end
