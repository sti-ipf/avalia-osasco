class QuestionText < ActiveRecord::Base
  belongs_to :question
  belongs_to :segment
end
