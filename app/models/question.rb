class Question < ActiveRecord::Base
  has_many :question_texts
  belongs_to :service_level
  belongs_to :indicator
end
