class ReportData < ActiveRecord::Base
  belongs_to :indicator
  belongs_to :segment
  belongs_to :dimension
  belongs_to :school
  belongs_to :service_level

  DEFAULT_PARAMS = {
    :minimum_value    => 0,
    :maximum_value    => 5,
    :margins          => 5,
    :top_margin       => 0,
    :legend_font_size => 16,
    :legend_box_size  => 14,
    :title_margin     => 50,
    :title_font_size  => 19,
    :bar_spacing      => 1,
    :marker_count     => 5,
    :legend_margin    => 52,
    :sort             => false,
    :top_label_size   => 10
  }

  SEGMENTS_ORDER = ['Professores', 'Gestores', 'Funcionários', 'Familiares', 'Educandos']
  SEGMENTS_ORDER_CONVENIADAS = ['Gestores', 'Coordenadores pedagógicos', 'Professores', 'Funcionários', 'Familiares']
  #SEGMENTS_ORDER = ['Gestores', 'Trabalhadores', 'Familiares']

  COLORS = ['#FFC540', '#6786B4', '#72AE6E']

  def self.custom_round(number, decimals = 2)
    number.to_s[0..decimals].to_f
  end
  def self.prettify_float(i)
    i.to_i == i ? i.to_i : i
  end

  def self.generate(school_id)
    school = School.find(school_id)
    school.service_levels.each do |service_level|
      questions = Question.all(:conditions => {:service_level_id => service_level.id})
      service_level.segments.each do |segment|
        indicators_already_proccessed = []
        questions.each do |question|

          indicator = question.indicator
          if indicators_already_proccessed.include?(indicator.id)
            next
          end
          indicators_already_proccessed << indicator.id

          questions_ids = Question.all(:conditions => {:service_level_id => service_level.id, :indicator_id => indicator.id}).collect(&:id).join(',')
          total = 0
          answers_ids = []
          no_know = []
          no_answer = []

          question_texts = QuestionText.all(:conditions => "segment_id = #{segment.id} AND question_id IN (#{questions_ids})") 
          question_texts.each do |question_text|
            answer = Answer.first(:conditions => {:question_text_id => question_text.id, :school_id => school.id, :segment_id => segment.id})
            if !answer.nil?
              total += answer.media if answer.media.class != String
              answers_ids << answer.id if ((!answer.media.nil? || !answer.do_not_know.nil?) && answer.media.class != String)
              no_know << answer.id if !answer.do_not_know.nil?
              no_answer << answer.id if !answer.do_not_answer.nil?
            end
          end

          if no_know.count > 0 && total == 0
            media = 0
          elsif (answers_ids.count > 0 && no_answer.count > 0 && no_know.count == 0 && total == 0)
            media = -1
          elsif (answers_ids.count == 0 || total == 0)
            media = nil
          else
            media = custom_round((total/answers_ids.count), 2)
          end
          ReportData.create(:media => media, :answers_ids => answers_ids.join(','), :indicator_id => indicator.id, :segment_id => segment.id, 
            :dimension_id => indicator.dimension.id, :school_id => school.id, :service_level_id => service_level.id)

        end

      end
    end
  end

  def self.question_table(school_id, service_level_id, dimension_number)
    table_data = Hash.new
    question_numbers = QuestionText.find_by_sql("
      SELECT DISTINCT question_number FROM question_texts
      WHERE dimension_id IN (SELECT id FROM dimensions WHERE service_level_id = #{service_level_id} AND number = #{dimension_number})
      ORDER BY SUBSTRING_INDEX( question_number , '.', 1 ) + 0,
      SUBSTRING_INDEX(SUBSTRING_INDEX( question_number , '.', 2 ), '.', -1) + 0,
      SUBSTRING_INDEX( question_number , '.', -1 ) + 0")
    question_numbers.each do |q|
      table_data[q.question_number] = []
      school = School.find(school_id)
      group_id = Group.find_by_sql("SELECT id FROM groups 
        WHERE ID IN (SELECT group_id FROM groups_schools WHERE school_id = #{school.id})
        AND service_level_id = #{service_level_id}").first.id
      answers = Answer.find_by_sql("SELECT *, s.name as segment_name FROM answers a
        INNER JOIN question_texts qt ON a.question_text_id = qt.id
        INNER JOIN segments s ON a.segment_id = s.id
        WHERE a.school_id = #{school_id}
        AND s.id IN (SELECT id FROM segments WHERE service_level_id = #{service_level_id})
        AND qt.question_number = '#{q.question_number}'")
      group_answers = Answer.find_by_sql("
        SELECT *, s.name as segment_name FROM answers a
        INNER JOIN question_texts qt ON a.question_text_id = qt.id
        INNER JOIN segments s ON a.segment_id = s.id
        WHERE a.school_id IN (SELECT school_id FROM groups_schools WHERE group_id = #{group_id})
        AND s.id IN (SELECT id FROM segments WHERE service_level_id = #{service_level_id})
        AND qt.question_number = '#{q.question_number}'")

      schools_answers = Answer.find_by_sql("
        SELECT *, s.name as segment_name FROM answers a
        INNER JOIN question_texts qt ON a.question_text_id = qt.id
        INNER JOIN segments s ON a.segment_id = s.id
        WHERE qt.question_number = '#{q.question_number}'")

      total = 0
      table_data[q.question_number] = Hash.new

      answers.each do |a|
        do_not_answer = (a.do_not_answer == nil)? 0 : a.do_not_answer

        table_data[q.question_number][a.segment_name] = [a.media, do_not_answer]
        total += a.media if a.media.class != String
      end

      group_total = 0
      group_answers.each do |a|
        group_total += a.media if a.media.class != String
      end

      schools_total = 0
      schools_answers.each do |a|
        schools_total += a.media if a.media.class != String
      end
      if (answers.count == 0 || total == 0)
        table_data[q.question_number]['Média geral da questão'] = '-'
      else
        table_data[q.question_number]['Média geral da questão'] = (total/answers.count).try(:round, 1)
      end

      if (group_answers.count == 0 || group_total == 0)
        table_data[q.question_number]['Média por agrupamento'] = '-'
      else
        table_data[q.question_number]['Média por agrupamento'] = (group_total/group_answers.count).try(:round, 1)
      end

      if (schools_answers.count == 0 || schools_total == 0)
        table_data[q.question_number]['Média da rede'] = '-'
      else
        table_data[q.question_number]['Média da rede'] = (schools_total/schools_answers.count).try(:round, 1)
      end

    end
    table_data
  end

  def self.get_group_data_geral(service_level_id)
    groups = Group.all(:conditions => "service_level_id = #{service_level_id}")
    group_data = Hash.new
    groups.each do |group|
      data = ReportData.find_by_sql("
        SELECT d.number as dimension_number, ROUND(AVG(media),1) as calculated_media FROM report_data rd
        INNER JOIN dimensions d ON d.id = rd.dimension_id
        WHERE rd.service_level_id = #{service_level_id}
        AND school_id IN (SELECT school_id FROM groups_schools WHERE group_id = #{group.id})
        AND rd.media >= 0
        GROUP by rd.dimension_id
      ")
      group_data[group.id] = {}
      data.each do |d|
        group_data[group.id][d.dimension_number] = d.calculated_media
      end
    end
    group_data
  end

  def self.indicator_graphic(school_id, service_level_id, dimension_number, indicator_number)
    school = School.find(school_id)
    dimension = Dimension.first(:conditions => "number = #{dimension_number} AND service_level_id = #{service_level_id}")
    indicator = Indicator.first(:conditions => "number = #{indicator_number} AND dimension_id = #{dimension.id}")
    group_id = Group.find_by_sql("SELECT id FROM groups 
        WHERE ID IN (SELECT group_id FROM groups_schools WHERE school_id = #{school.id})
        AND service_level_id = #{service_level_id}").first.id
    school_data = ReportData.find_by_sql("
      SELECT s.name, media  as calculated_media FROM report_data r
      INNER JOIN dimensions d ON r.dimension_id = d.id
      INNER JOIN indicators i ON r.indicator_id = i.id
      INNER JOIN segments s ON r.segment_id = s.id
      WHERE r.school_id = #{school_id} AND r.service_level_id = #{service_level_id}
      AND d.number = #{dimension_number} AND i.number = #{indicator_number}
      AND media >= 0 AND media <= 5
      GROUP BY s.name")
    
    schools_averages = ReportData.find_by_sql("
      SELECT s.name, ROUND(AVG(media),1) as calculated_media FROM report_data r
      INNER JOIN segments s ON s.id = r.segment_id
      WHERE dimension_id IN (SELECT id FROM dimensions WHERE number = #{dimension_number})
      AND indicator_id IN (SELECT id FROM indicators WHERE number = #{indicator_number})
      AND segment_id IN (SELECT id FROM segments WHERE service_level_id = #{service_level_id})
      AND media >= 0 AND media <= 5
      GROUP BY s.name")
    
    group_averages = ReportData.find_by_sql("
      SELECT s.name, ROUND(AVG(media),1) as calculated_media FROM report_data r
      INNER JOIN segments s ON s.id = r.segment_id
      WHERE dimension_id IN (SELECT id FROM dimensions WHERE number = #{dimension_number})
      AND indicator_id IN (SELECT id FROM indicators WHERE number = #{indicator_number})
      AND segment_id IN (SELECT id FROM segments WHERE service_level_id = #{service_level_id})
      AND school_id IN (SELECT school_id FROM groups_schools WHERE group_id = #{group_id})
      AND media >= 0 AND media <= 5
      GROUP BY s.name")
      

    labels = get_labels(school_data, service_level_id)

    school_values = get_segments_values_for_dimension_graphic(labels, school_data)
    group_values = get_segments_values_for_dimension_graphic(labels, group_averages)
    schools_values = get_segments_values_for_dimension_graphic(labels, schools_averages)

    values = []
    values << ["Média UE", school_values]
    values << ["Média Agrupamento", group_values]
    values << ["Média Geral da Rede", schools_values]


    g = Gruff::Bar.new("900x380")
    g.title = get_indicator_graphic_title(dimension, indicator)

    i_color = 0
    values.each do |v|
      g.data(v.first, v.last, COLORS[i_color])
      i_color += 1
    end
    puts values.inspect
    g.data(" ", Array.new(values.count, 0), "#fff")

    
    g.theme = {
            :marker_color => 'white',
            :background_colors => 'white'
          }

    DEFAULT_PARAMS.each {|k, v| g.instance_variable_set("@#{k}", v)}
    
    label_number = 0
    labels.each do |l|
      if l == 'Coordenadores pedagógicos'
        l = 'Coord. ped.'
      end

      if l == 'Gestores' && service_level_id == 6
        l = 'Gerentes'
      end

      g.labels[label_number] = l
      label_number += 1
    end
    g.labels[labels.length] = "Média Geral"

    
    g.write("#{Rails.root.to_s}/tmp/#{school_id}_#{service_level_id}_#{dimension_number}_#{indicator_number}_ue_indicator_graphic.jpg")
  end

  def self.index_table_data(school_id, service_level_id)
    data = Hash.new
    dimensions = Dimension.all(:conditions => "service_level_id = #{service_level_id}")
    segments = []
    dimensions.each do |d|
      data[d.number] = Hash.new
      dimension_data = ReportData.find_by_sql("SELECT s.name, ROUND(AVG(media),1) as calculated_media FROM report_data r
            INNER JOIN segments s ON s.id = r.segment_id
            WHERE r.school_id = #{school_id} AND r.service_level_id = #{service_level_id} AND r.dimension_id = #{d.id}
            AND media >= 0 AND media <= 5
            GROUP BY s.name")
      total = 0

      dimension_data.each do |dd|
        segments << dd.name if !segments.include?(dd.name)
        data[d.number][dd.name] = custom_round((dd.calculated_media/5).to_f, 3)
        total += dd.calculated_media
      end
      data[d.number]['name'] = d.name
      if dimension_data.count == 0
        data[d.number]['index'] = 0
      else
        data[d.number]['index'] = custom_round(((total/dimension_data.count)/5).to_f, 3)
      end
    end

    index_total = 0
    segments.each do |s|
      total = 0
      count = 0
      dimensions.each do |d|    
        if !data[d.number][s].nil?
          total += data[d.number][s]
          count += 1
        end
      end
      data[s] = custom_round((total/count), 3)
      index_total += data[s]
    end

    data['index'] = custom_round((index_total/segments.count), 3)

    data
  end

  def self.dimension_graphic(school_id, service_level_id, dimension_number)
    school = School.find(school_id)
    dimension = Dimension.first(:conditions => "number = #{dimension_number} AND service_level_id = #{service_level_id}")
    group_id = Group.find_by_sql("SELECT id FROM groups 
        WHERE ID IN (SELECT group_id FROM groups_schools WHERE school_id = #{school.id})
        AND service_level_id = #{service_level_id}").first.id
    school_data = ReportData.find_by_sql("
      SELECT s.name, ROUND(AVG(media),1) as calculated_media FROM report_data r
      INNER JOIN segments s ON s.id = r.segment_id
      WHERE r.school_id = #{school_id} AND r.service_level_id = #{service_level_id} AND r.dimension_id = #{dimension.id}
        AND media >= 0 AND media <= 5
      GROUP BY s.name")

    schools_averages = ReportData.find_by_sql("
      SELECT s.name, ROUND(AVG(media),1) as calculated_media FROM report_data r
      INNER JOIN segments s ON s.id = r.segment_id
      WHERE dimension_id IN (SELECT id FROM dimensions WHERE number = #{dimension_number})
      AND segment_id IN (SELECT id FROM segments WHERE service_level_id = #{service_level_id})
      AND media >= 0 AND media <= 5
      GROUP BY s.name")
    
    group_averages = ReportData.find_by_sql("
      SELECT s.name, ROUND(AVG(media),1) as calculated_media FROM report_data r
      INNER JOIN segments s ON s.id = r.segment_id
      WHERE dimension_id IN (SELECT id FROM dimensions WHERE number = #{dimension_number})
      AND school_id IN (SELECT school_id FROM groups_schools WHERE group_id = #{group_id})
      AND segment_id IN (SELECT id FROM segments WHERE service_level_id = #{service_level_id})
      AND media >= 0 AND media <= 5
      GROUP BY s.name")

    labels = get_labels(school_data, service_level_id)

    school_values = get_segments_values_for_dimension_graphic(labels, school_data)
    group_values = get_segments_values_for_dimension_graphic(labels, group_averages)
    schools_values = get_segments_values_for_dimension_graphic(labels, schools_averages)

    values = []
    values << ["Média UE", school_values]
    values << ["Média Agrupamento", group_values]
    values << ["Média Geral da Rede", schools_values]

    puts values.inspect

    g = Gruff::Bar.new("900x500")
    g.title = get_dimension_graphic_title(service_level_id, dimension)

    i_color = 0
    values.each do |v|
      g.data(v.first, v.last, COLORS[i_color])
      i_color += 1
    end
    
    g.data(" ", Array.new(values.count, 0), "#fff")

    
    g.theme = {
            :marker_color => 'white',
            :background_colors => 'white'
          }

    DEFAULT_PARAMS.each {|k, v| g.instance_variable_set("@#{k}", v)}
    
    label_number = 0
    labels.each do |l|

      if l == 'Coordenadores pedagógicos'
        l = 'Coord. ped.'
      end
      if l == 'Gestores' && service_level_id == 6
        l = 'Gerentes'
      end
      g.labels[label_number] = l
      label_number += 1
    end
    g.labels[labels.length] = "Média Geral"

    
    g.write("#{Rails.root.to_s}/tmp/#{school_id}_#{service_level_id}_#{dimension_number}_ue_dimension_graphic.jpg")
  end

  def self.get_labels(data, service_level_id)
    labels = []
    if service_level_id == 6
      segment_order = SEGMENTS_ORDER_CONVENIADAS
    else
      segment_order = SEGMENTS_ORDER
    end
    segment_order.each do |s|
      data.each do |d|
        if d.name == s && !d.calculated_media.nil?
          labels << d.name 
          puts d.calculated_media
        end
      end
    end
    labels
  end

  def self.get_dimension_graphic_title(service_level_id, dimension)
    service_level = ServiceLevel.find(service_level_id)
    title = "Dimensão #{dimension.number}. #{dimension.name} (#{service_level.name})"
    new_title = ''
    control_title = 0
    if title.length > 74
      title.split(' ').each do |t|
        if control_title > 70
          new_title << "\n#{t}"
          control_title = 0
          control_title  += "\n#{t}".length
        else
          new_title << " #{t}"
          control_title  += " #{t}".length
        end
      end
      return new_title
    else
      return title
    end
  end

  def self.get_dimension_graphic_title_geral(service_level_id, dimension)
    if [1,2].include?(service_level_id)
      sl = "Educação Infantil"
    elsif [6].include?(service_level_id)
      sl = "Creches Conveniadas"
    elsif [3].include?(service_level_id)
      sl = "Educação Fundamental"
    elsif [4].include?(service_level_id)
      sl = "EJA"
    end
    title = "   "
    new_title = ''
    control_title = 0
    if title.length > 74
      title.split(' ').each do |t|
        if control_title > 70
          new_title << "\n#{t}"
          control_title = 0
          control_title  += "\n#{t}".length
        else
          new_title << " #{t}"
          control_title  += " #{t}".length
        end
      end
      return new_title
    else
      return title
    end
  end

  def self.get_indicator_graphic_title(dimension, indicator)
    title = "#{dimension.number}.#{indicator.number}.#{indicator.name}"
    new_title = ''
    control_title = 0
    if title.length > 74
      title.split(' ').each do |t|
        if control_title > 70
          new_title << "\n#{t}"
          control_title = 0
          control_title  += "\n#{t}".length
        else
          new_title << " #{t}"
          control_title  += " #{t}".length
        end
      end
      return new_title
    else
      return title
    end
  end

  def self.get_segments_values_for_dimension_graphic(labels, data, dimension_number = nil, service_level_id = nil, indicator_number = nil)
    values = []
    segments_without_answers = []
    labels.each do |l|
      data.each do |d|
        if d.name == l 
          values << d.calculated_media
          segments_without_answers << d.calculated_media if d.calculated_media == 0
        end
      end
    
    end
    if service_level_id.nil?
      total = 0
      values.each do |v|
        total += v
      end
      
      values_total = values.count - segments_without_answers.count 
      if (values_total == 0 || total == 0)
        values << 0
      else
        values << custom_round((total/(values_total)))
      end
    elsif !indicator_number.nil?
      values << IndicatorsDataGeral.first(:conditions => "dimension_number = #{dimension_number} and service_level_id = #{service_level_id} and indicator_number = #{indicator_number}").value
    else
      values << DimensionsAverageGeral.first(:conditions => "dimension_number = #{dimension_number} and service_level_id = #{service_level_id}").value
    end    
    
    values
  end

  def self.dimension_graphic_geral(service_level_ids, dimension_number)
    dimension = Dimension.first(:conditions => "number = #{dimension_number} AND service_level_id = #{service_level_ids[0]}")

    data = []

    service_level_ids.each do |sl_id|
      data << [sl_id,
        IndicatorsAverageGeral.find_by_sql("
            SELECT segment as name, ROUND(AVG(value),1) as calculated_media FROM indicators_average_geral g
            WHERE dimension_number = #{dimension_number} 
            AND service_level_id = #{sl_id}
            GROUP BY name")]
    end

    labels = get_labels(data.first.last, service_level_ids.first)

    values = []
    data.each do |d|
      values << [ServiceLevel.find(d.first).name, get_segments_values_for_dimension_graphic(labels, d.last, dimension_number, d.first)]
    end

    puts values.inspect

    g = Gruff::Bar.new("900x500")
    g.title = get_dimension_graphic_title_geral(service_level_ids[0], dimension)

    i_color = 0
    values.each do |v|
      if service_level_ids.count == 1
        case service_level_ids.first 
          when 1
            colors = ["#00AE68"]
          when 2
            colors = ["#66A1D2"]
          when 3
            colors = ["#FFC540"]
          when 4
            colors = ["#FF4040"]
          when 6
            colors = ["#996AD6"]
        end
        g.data(v.first, v.last, colors[0])
      else
        case v.first
          when 'CRECHE'
            colors = ["#00AE68"]
          when 'EMEI'
            colors = ["#66A1D2"]
          end
        g.data(v.first, v.last, colors[0])
      end
      i_color += 1
    end
    
    g.data(" ", Array.new(values.count, 0), "#fff")

    
    g.theme = {
            :marker_color => 'white',
            :background_colors => 'white'
          }

    DEFAULT_PARAMS.each {|k, v| g.instance_variable_set("@#{k}", v)}

    g.hide_legend = true if service_level_ids.first == 6
    
    label_number = 0
    labels.each do |l|

      if l == 'Coordenadores pedagógicos'
        l = 'Coord. ped.'
      end
      if l == 'Gestores' && service_level_ids[0] == 6
        l = 'Gerentes'
      end
      g.labels[label_number] = l
      label_number += 1
    end
    g.labels[labels.length] = "Média Geral"

    
    g.write("#{Rails.root.to_s}/tmp/#{service_level_ids[0]}_#{service_level_ids[1]}_#{dimension_number}_ue_dimension_graphic_report_geral.jpg")
  end

  def self.indicator_graphic_geral(service_level_ids, dimension_number, indicator_number)
    dimension = Dimension.first(:conditions => "number = #{dimension_number} AND service_level_id = #{service_level_ids[0]}")
    indicator = Indicator.first(:conditions => "number = #{indicator_number} AND dimension_id = #{dimension.id}")
    data = []

    service_level_ids.each do |sl_id|
      data << [sl_id,
        IndicatorsAverageGeral.find_by_sql("
          SELECT segment as name, value as calculated_media FROM indicators_average_geral
          WHERE service_level_id = #{sl_id}
          AND dimension_number = #{dimension_number}
          AND indicator_number = #{indicator_number}
          GROUP BY segment
        ")
        ]
    end

    labels = get_labels(data.first.last, service_level_ids.first)

    values = []
    data.each do |d|
      values << [ServiceLevel.find(d.first).name, get_segments_values_for_dimension_graphic(labels, d.last, dimension_number, d.first, indicator_number)]
    end

    g = Gruff::Bar.new("900x380")
    g.title = get_indicator_graphic_title(dimension, indicator)

    i_color = 0
    values.each do |v|
      if service_level_ids.count == 1
        case service_level_ids.first 
          when 1
            colors = ["#00AE68"]
          when 2
            colors = ["#66A1D2"]
          when 3
            colors = ["#FFC540"]
          when 4
            colors = ["#FF4040"]
          when 6
            colors = ["#996AD6"]
        end
        g.data(v.first, v.last, colors[i_color])
      else
        g.data(v.first, v.last, COLORS[i_color])
      end
      i_color += 1
    end
    puts values.inspect
    g.data(" ", Array.new(values.count, 0), "#fff")

    
    g.theme = {
            :marker_color => 'white',
            :background_colors => 'white'
          }

    DEFAULT_PARAMS.each {|k, v| g.instance_variable_set("@#{k}", v)}
    
    g.hide_legend = true if service_level_ids.count == 1

    label_number = 0
    labels.each do |l|
      if l == 'Coordenadores pedagógicos'
        l = 'Coord. ped.'
      end

      if l == 'Gestores' && service_level_ids[0] == 6
        l = 'Gerentes'
      end

      g.labels[label_number] = l
      label_number += 1
    end
    g.labels[labels.length] = "Média Geral"

    
    g.write("#{Rails.root.to_s}/tmp/#{service_level_ids[0]}_#{service_level_ids[1]}_#{dimension_number}_#{indicator_number}_ue_indicator_graphic_geral.jpg")
  end

end