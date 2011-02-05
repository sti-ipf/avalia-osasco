class QuestionsParty < ActiveRecord::Base
  has_many :questions
  belongs_to :indicators_party

  def mean_by_sl
    questions = self.questions
    mean = 0
    questions_means = []
    questions.each do |q|
      @curr_answers = {}
      answers = q.answers.min_participants(0).newer
      answers.each do |a|
        @curr_answers[a.user_id] ||= a.mean
      end
      if @curr_answers.keys.size > 0
        questions_means << @curr_answers.avg
      end
    end
    if questions_means.size > 0
      mean = questions_means.avg
    end
    mean
  end

 def mean_by_group(group)
   questions = self.questions
   mean = 0
   questions_means = []
   questions.each do |q|
     answers = q.answers
     answers = q.answers.by_group(group).min_participants(0).newer
     @curr_answers = {}
     answers.each do |a|
       @curr_answers[a.user_id] ||= a.mean
     end
     if @curr_answers.keys.size > 0
       questions_means << @curr_answers.avg
     end
   end
   if questions_means.size > 0
     mean = questions_means.avg
   end
   mean
 end
 
end

