class QuestionText < ActiveRecord::Base
  belongs_to :question
  belongs_to :segment
  has_one :answer
end
