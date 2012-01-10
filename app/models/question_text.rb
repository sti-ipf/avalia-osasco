class QuestionText < ActiveRecord::Base
  belongs_to :question
  belongs_to :segment
  has_many :answers
end
