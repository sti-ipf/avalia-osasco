# -*- encoding : utf-8 -*-

file_name = 'segmentos_por_escola'
data = []
School.all.each do |s|
  s.service_levels.each do |sl|
    segments_answered_total = Answer.find_by_sql("select distinct segment_id from answers 
      where school_id = #{s.id} and segment_id IN 
      (select id from segments where service_level_id = #{sl.id})").count
    segments_total = Segment.all(:conditions => "service_level_id = #{sl.id}").count

    if segments_answered_total != segments_total
      data << [segments_answered_total, segments_total, s.name, sl.name]
    end
  end
end

FasterCSV.open("tmp/#{file_name}.csv", "w") do |csv|
  csv << ["Total de segmentos que respondeu", "Total de segmentos", "Escola", "Nível de serviço"]
  data.each do |d|
    csv << d
  end
end
