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
        next if d[QUESTION_TEXT].include?('Texto')
        
        service_level = ServiceLevel.first(:conditions => "name = '#{d[SERVICE_LEVEL]}'")
        puts "service_level nula" if service_level.nil?
        dimension = Dimension.first(:conditions => "number = #{d[DIMENSION]} AND service_level_id = #{service_level.id}")
        puts "dimensao nula" if dimension.nil?
        indicator = Indicator.first(:conditions => "number = #{d[INDICATOR]} AND dimension_id = #{dimension.id}") 
        puts "indicator nula" if indicator.nil?
        segment = Segment.first(:conditions => "service_level_id = #{service_level.id} AND name = '#{d[SEGMENT]}'")
        puts "segment nula" if segment.nil?
        question = Question.create_or_find(d[QUESTION], service_level.id, indicator.id)
        QuestionText.create(:text => d[QUESTION_TEXT], :question_id => question.id, :segment_id => segment.id)
      end
    end
    
  end

end