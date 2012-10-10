ActiveAdmin::Dashboards.build do


  section "Estatísticas gerais" do

    total_schools = School.count
    
    total_schools_started_answer = ComplexQuery.get_total_schools_started_answer[0]
    total_schools_pending_start = total_schools - total_schools_started_answer
    total_schools_pending_start_percentage = '%.2f' % ((total_schools_pending_start/total_schools.to_f)*100)
    total_schools_pending_start_percentage = 0 if total_schools_pending_start_percentage == "nan"
    total_schools_started_answer_percentage = '%.2f' % ((total_schools_started_answer/total_schools.to_f)*100)
    total_schools_started_answer_percentage = 0 if total_schools_started_answer_percentage == "nan"
    ul do
      li do
        "Total de escola: #{total_schools}"
      end
      li do
        "Total de escola que iniciaram a resposta: #{total_schools_started_answer} (#{total_schools_started_answer_percentage}%)"
      end
      li do
        "Total de escola pendente inicio: #{total_schools_pending_start} (#{total_schools_pending_start_percentage}%)"
      end
      li do
        link_to "Mapa das respostas", map_path
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
        total_schools_pending_start_percentage = '%.2f' % ((total_schools_pending_start/total_schools.to_f)*100)
      total_schools_pending_start_percentage = 0 if total_schools_pending_start_percentage == "nan"
      total_schools_started_answer_percentage = '%.2f' % ((total_schools_started_answer/total_schools.to_f)*100)
      total_schools_started_answer_percentage = 0 if total_schools_started_answer_percentage == "nan"
        ul do
          li do
            "Total de escolas: #{total_schools}"
          end
          li do
            "Total de escola que iniciaram a resposta: #{total_schools_started_answer} (#{total_schools_started_answer_percentage}%)"
          end
          li do
            "Total de escola pendente inicio: #{total_schools_pending_start} (#{total_schools_pending_start_percentage}%)"
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

  section "Gerenciamento do sistema" do 
    ul do
      li do
        if Password.count > 0
          link_to "Gerar senhas", generate_passwords_path, :remote => true, :confirm=>"Você tem certeza que deseja regerar as senhas?"
        else 
          link_to "Gerar senhas", generate_passwords_path, :remote => true
        end
      end
      li do        
        link_to "Importar instrumental", import_instrument_path, :id => "import_instrument"        
      end
      li do
        link_to "Pré-gerar estatísticas das respostas", generate_answer_stats_path, :remote => true
      end
      
    end
  end

end

