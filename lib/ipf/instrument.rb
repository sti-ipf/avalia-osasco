module Ipf

  class Instrument

    DIMENSION = 0
    INDICATOR = 1
    QUESTION = 2
    SERVICE_LEVEL = 3
    SEGMENT = 4
    QUESTION_TEXT = 5

    def self.import(file)
      data = FasterCSV.read(file)
      data.each do |d|
        next if d[QUESTION_TEXT] == 'Texto pergunta'
        
        service_level = ServiceLevel.first(:conditions => "name = '#{d[SERVICE_LEVEL]}'")
        dimension = Dimension.first(:conditions => "number = #{d[DIMENSION]} AND service_level_id = #{service_level.id}")
        indicator = Indicator.first(:conditions => "number = #{d[INDICATOR]} AND dimension_id = #{dimension.id}") 
        segment = Segment.first(:conditions => "service_level_id = #{service_level.id} AND name = '#{d[SEGMENT]}'")
        question = Question.create_or_find(d[QUESTION], service_level.id, indicator.id)
        QuestionText.create(:text => d[QUESTION_TEXT], :question_id => question.id, :segment_id => segment.id)
      end
    end
    
  end

end