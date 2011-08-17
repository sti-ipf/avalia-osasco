class Segment < ActiveRecord::Base
  belongs_to :service_level
  has_many :question_text
  has_many :passwords
end
