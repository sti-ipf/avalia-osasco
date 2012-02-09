GeneralData.delete_all

service_levels = ServiceLevel.all(:conditions => "id NOT IN (5)")

service_levels.each do |service_level|
  dimensions = Dimension.all(:conditions => "service_level_id = #{service_level.id}")
  dimensions.each do |dimension|
    indicators = Indicator.all(:conditions => "dimension_id = #{dimension.id}")
    indicators.each do |indicator|
      data = ReportData.find_by_sql("
        SELECT s.name, media  as calculated_media FROM report_data r
        INNER JOIN dimensions d ON r.dimension_id = d.id
        INNER JOIN indicators i ON r.indicator_id = i.id
        INNER JOIN segments s ON r.segment_id = s.id
        WHERE r.service_level_id = #{service_level.id}
        AND r.dimension_id IN (SELECT id FROM dimensions WHERE id = #{dimension.id})
        AND r.indicator_id IN (SELECT id FROM indicators WHERE id = #{indicator.id})
        AND r.segment_id IN (SELECT id FROM segments WHERE service_level_id = #{service_level.id})
        AND media >= 0 AND media <= 5
        GROUP BY s.name")
      data.each do |d|
        GeneralData.create(:service_level_id => service_level.id, 
          :dimension_number => dimension.number,
          :indicator_number => indicator.number,
          :segment => d.name,
          :media => d.calculated_media)
      end
    end
  end
end


