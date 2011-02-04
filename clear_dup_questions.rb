class QuestionTools
  def self.merge_dup_questions(questions)
    questions.each do |q|
      dups = questions.select { |q1| q1.number == q.number && q1.survey == q && q1 != q }
      dups.each do |dup|
        dup.answers.each { |a| a.question_id = q.id; a.save! }
        questions.delete(dup)
        dup.delete
      end
    end
  end
end
