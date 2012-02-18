IndicatorsAverageGeral.destroy_all
DimensionsAverageGeral.destroy_all
ServiceLevel.all.each do |s|
  s.dimensions.each do |d|
    indicators_total = []
    indicators_data = []
    d.indicators.each do |i|
      data = GeneralData.find_by_sql("
        SELECT segment, media FROM general_data
        WHERE service_level_id = #{s.id}
        AND dimension_number = #{d.number}
        AND indicator_number = #{i.number}
        GROUP BY segment
        ")
      total = (data.collect(&:media).sum/data.size.to_f)
      if total.nan?
        total = 0
      else
        total = total.try(:round, 1)
      end
      data.each do |dd|
        IndicatorsAverageGeral.create(
          :service_level_id => s.id,
          :dimension_id => d.id,
          :dimension_number => d.number,
          :indicator_id => i.id,
          :indicator_number => i.number,
          :segment => dd.segment,
          :value => dd.media)
      end
      indicators_total << total
      indicators_data << [i, total]
    end

    indicators_data.each do |dd|
      IndicatorsDataGeral.create(
          :service_level_id => s.id,
          :dimension_id => d.id,
          :dimension_number => d.number,
          :indicator_id => dd.first.id,
          :indicator_number => dd.first.number,
          :value => dd.last)
    end


    indicators_total = indicators_total.sum/indicators_total.size.to_f
    if indicators_total.nan?
      indicators_total = 0
    else
      indicators_total = indicators_total.try(:round, 1)
    end
    DimensionsAverageGeral.create(
          :service_level_id => s.id,
          :dimension_id => d.id,
          :dimension_number => d.number,
          :value => indicators_total)  
  end
end