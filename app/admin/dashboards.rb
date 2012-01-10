ActiveAdmin::Dashboards.build do

  section "Estatísticas gerais" do
    total_schools = School.count
    total_schools_started_answer = ComplexQuery.get_total_schools_started_answer[0]
    total_schools_pending_start = total_schools - total_schools_started_answer
    ul do
      li do
        "Total de escola: #{total_schools}"
      end
      li do
        "Total de escola que iniciaram a resposta: #{total_schools_started_answer} (#{'%.2f' % ((total_schools_started_answer/total_schools.to_f)*100)}%)"
      end
        li do
          "Total de escola pendente inicio: #{total_schools_pending_start} (#{'%.2f' % ((total_schools_pending_start/total_schools.to_f)*100)}%)"
        end
    end
  end

  begin
    sls = ServiceLevel.all(:include => [:segments])
    sls.each do | sl |
      section "Estatísticas #{sl.name}" do
        total_schools = School.joins("INNER JOIN schools_service_levels sl on schools.id = sl.school_id and sl.service_level_id = #{sl.id}").count
        total_schools_started_answer = ComplexQuery.get_total_schools_started_answer_by_service_level(sl.id)
        total_schools_pending_start = total_schools - total_schools_started_answer

        ul do
          li do
            "Total de escolas: #{total_schools}"
          end
          li do
            "Total de escola que iniciaram a resposta: #{total_schools_started_answer} (#{'%.2f' % ((total_schools_started_answer/total_schools.to_f)*100)}%)"
          end
          li do
            "Total de escola pendente inicio: #{total_schools_pending_start} (#{'%.2f' % ((total_schools_pending_start/total_schools.to_f)*100)}%)"
          end
        end
        b "Porcentagem de dimensões completadas por segmento"
        table do
          tr
            th 'Dimensão'
            sl.segments.each do |seg|
              th seg.name
            end
          sl.dimensions.each do |dim|
            tr
              td dim.number
              sl.segments.each do |seg|
                total = ComplexQuery.get_total_started_answer_by_service_level_and_segment_and_dimension_id(sl.id, seg.name, dim.id)  
                td "#{'%.2f' % ((total/total_schools.to_f)*100)}%"
              end
          end
            
        end
      end
    end
  rescue
  end

end

