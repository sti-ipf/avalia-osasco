GeneralReportData.delete_all
array = [['creche', 1], ['emei', 2],['emef', 3]]
array.each do |a|
  FasterCSV.foreach("tmp/#{a.first}.csv") do |row|
    i = 0
    sl_id = a.last
    row.each do |r|
      i+= 1
      dimension = Dimension.first(:conditions => "number = #{i} AND service_level_id = #{sl_id}")
      segment = Segment.first(:conditions => "service_level_id = #{sl_id}")
      GeneralReportData.create(:media => r[0..3], :data_type => 0, :service_level_id => sl_id, :year => 2010, 
        :dimension_id => dimension.id, :segment_id => segment.id)
    end
  end
end

array = [['creche', 4, 1], ['emei', 4, 2],['emef', 5, 3]]
emef_segments = ['Educandos', 'Familiares', 'Funcionários', 'Gestores', 'Professores']
infantil_segments = ['Familiares', 'Funcionários', 'Gestores', 'Professores']
array.each do |a|
  last_indicator_number = last_dimension_number = 0
  indicators_numbers = [] 
  FasterCSV.foreach("tmp/#{a.first}_indicadores.csv") do |row|
    dimension_number = row.last.split('.').first
    indicator_number = row.last.split('.').last
    indicators_numbers = [] if dimension_number != last_dimension_number
    i = 0
    sl_id = a.last
    rows = []
    z = 0
    
  
    if indicators_numbers.include?(indicator_number) && last_indicator_number == '9'
      indicator_number = '10'
    else
      indicators_numbers << indicator_number
    end

    
    row.each do |r|
      z += 1
      rows << r if !(z > a[1])
    end
    j = 0

    if a.first == 'emef'
      segments = emef_segments
    else
      segments = infantil_segments
    end

    rows.each do |r|
      dimension = Dimension.first(:conditions => "number = #{dimension_number} AND service_level_id = #{sl_id}")
      segment = Segment.first(:conditions => "service_level_id = #{sl_id} AND name = '#{segments[j]}'")
      indicator = Indicator.first(:conditions => "dimension_id = #{dimension.id} AND number = #{indicator_number}")
      GeneralReportData.create(:media => r[0..3], :data_type => 1, :service_level_id => sl_id, :year => 2010, 
        :dimension_id => dimension.id, :segment_id => segment.id, :indicator_id => indicator.id)
      j += 1
    end
    last_dimension_number = dimension_number
    last_indicator_number = indicator_number
  end
end