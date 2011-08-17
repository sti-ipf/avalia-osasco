class Answer < ActiveRecord::Base
  belongs_to :segment
  belongs_to :school
  belongs_to :question_text
end
