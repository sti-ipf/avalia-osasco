class Indicator < ActiveRecord::Base
  belongs_to :dimension
  has_many :questions
end
