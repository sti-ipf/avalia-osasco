class Answer < ActiveRecord::Base
  belongs_to :segment
  belongs_to :school
  belongs_to :question_text

  def media
    i = 0
    value = 0
    total = 0
    ["one", "two", "three", "four", "five"].each do |s|
      i += 1
      if !eval("self.#{s}").nil?
        value += eval("self.#{s}") * i
        total += eval("self.#{s}")
      end
    end

    if !self.do_not_know.nil?
      total += self.do_not_know
    end

    if (total == 0 || value == 0 && self.do_not_know.nil? && !self.do_not_answer.nil? )
      return "∅"
    elsif (total == 0 || value == 0)
      return 0
    else
      return (value/total.to_f).try(:round, 1)
    end

  end

end
