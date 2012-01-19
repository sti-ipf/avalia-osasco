module IPF
  class Burjato

    TEMPLATE_DIRECTORY= File.expand_path "#{RAILS_ROOT}/lib/templates"
    TEMP_DIRECTORY = File.expand_path "#{RAILS_ROOT}/tmp"
    PUBLIC_DIRECTORY = File.expand_path "#{RAILS_ROOT}/public"

    def generate_graphics(school_id, service_level_id)
      dimensions = Dimension.all(:conditions => "service_level_id = #{service_level_id}")
      DimensionData.generate_dimensions_graphic(school_id, service_level_id)
      dimensions.each do |d|
        puts "GERANDO GRÁFICOS PARA A DIMENSAO #{d.number}"
        DimensionData.generate_graphic_per_dimension(school_id, service_level_id, d.number)
        dimension_graphic(school_id, service_level_id, d.number)
        indicators = Indicator.all(:conditions => "dimension_id = #{d.id}", :order => "number ASC").collect(&:number)
        indicators.each do |i|
          indicator_graphic(school_id, service_level_id, d.number, i)
        end
      end
    end

    def generate_question_tables(school_id, service_level_id)
      dimensions = Dimension.all(:conditions => "service_level_id = #{service_level_id}")
      dimensions.each do |d|
        puts "GERANDO TABELA COM QUESTOES PARA A DIMENSAO #{d.number}"
        generate_question_table(school_id, service_level_id, d.number)
      end
    end

    def generate_practice_tables(school_id, service_level_id)
      dimensions = Dimension.all(:conditions => "service_level_id = #{service_level_id}")
      dimensions.each do |d|
        puts "GERANDO TABELA DE PRATICAS PARA A DIMENSAO #{d.number}"
        IPF::TableGenerator.generate_practices_table(school_id, service_level_id, d.number)
      end
    end

    def generate_index_table(school_id, service_level_id)
      generate_index_table(school_id, service_level_id)
    end

    def generate_file(school_id, service_level_id)
      @type = ServiceLevel.find(service_level_id).name

      case @type
        when "CRECHE"
          dimensions_total = 10
        when "EMEI"
          dimensions_total = 10
        when "EMEF"
          dimensions_total = 11
        when "EJA"
          dimensions_total = 9
        when "BURJATO"
          dimensions_total = 11
        when "CRECHE CONVENIADA"
          dimensions_total = 10
          @type = "CONVENIADA"
      end

      school = School.find(school_id)

      doc = RGhost::Document.new
      doc.define_tags do
        tag :font1, :name => 'HelveticaBold', :size => 12, :color => '#000000'
        tag :font2, :name => 'Helvetica', :size => 12, :color => '#000000'
        tag :font3, :name => 'CalibriBold', :size => 13, :color => '#535353'
        tag :index, :name => 'Helvetica', :size => 8, :color => '#000000'
        tag :indexwhite, :name => 'Helvetica', :size => 8, :color => '#FFFFFF'
      end

      school_name = "E.M.E.E. Dr. Edmundo Campanha Burjato"
      
      title = []
      tmp_title = ''
      school_name = school_name.split(' ')
      t_i = 0
      school_name.each do |s|
        title[t_i] ||= ''
        if title[t_i].length <= 40
          title[t_i] << "#{s} "
        else
          t_i += 1
          title[t_i] ||= ''
          title[t_i] << "#{s} "
        end

      end

      school_name = "E.M.E.E. Dr. Edmundo Campanha Burjato"

      ['capa_burjato', 'expediente'].each do |s|
        doc.image File.join(TEMPLATE_DIRECTORY, "#{s}.eps")
        if s == 'capa_burjato'
          t_y = [10.7, 10, 9.3]
          t_i = 0
          title.each do |t|
            doc.moveto :x => 7.6, :y => t_y[t_i]
            doc.show t, :with => :font3, :align => :show_left
            t_i += 1
          end
        end
        doc.next_page
      end

      if @type == "EMEF"
        initial_pages_total = 10
      elsif @type == "BURJATO"
        initial_pages_total = 9
      elsif @type == "CONVENIADA"
        initial_pages_total = 11
      else
        initial_pages_total = 10
      end

      

      initial_pages_total.times do |i|
        doc.image next_page_file(doc)
        if i == 0
          doc.moveto :x => 10.5, :y => 25.4
          doc.show "#{school_name}", :with => :font1, :align => :show_center
        end
        doc.next_page if i != (initial_pages_total-1)
      end

      segment_participation = Answer.find_by_sql("
        SELECT s.name, ROUND(AVG(quantity_of_people),1) AS calculated_media FROM answers a 
          INNER JOIN segments s on a.segment_id = s.id
          WHERE a.school_id = #{school.id}
          AND s.id IN (SELECT id FROM segments WHERE service_level_id = #{service_level_id})
          GROUP BY s.name
      ")

      y_points = [23.4, 22.7, 22, 21.3, 20.6]
      y_number = 0

      segment_participation.each do |p|
        doc.moveto :x => 6.1, :y => y_points[y_number]
        doc.show p.name, :with => :font2, :align => :show_center 
        doc.moveto :x => 14.5, :y => y_points[y_number]
        doc.show p.calculated_media.to_i, :with => :font2, :align => :show_center 
        y_number += 1
      end
      
      doc.next_page 

      if (@type != "EJA" && @type != "CONVENIADA")
        

        doc.image next_page_file(doc)  
        file = File.join(TEMP_DIRECTORY,"#{school_id}_#{service_level_id}_dimensions_graphic.jpg")
        puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

        doc.image file, :x => 1.6, :y => 15, :zoom => 55
        doc.showpage
        doc.image next_page_file(doc)
        y = 17
        (1..dimensions_total).each do |i|      
          file = File.join(TEMP_DIRECTORY,"#{school_id}_#{service_level_id}_#{i}_dimension_graphic.jpg")
          puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

          doc.image file, :x => 1.6, :y => y, :zoom => 50

          if [4, 6, 8].include?(i)
            y = 5.5
          else
            y = 19.2
            doc.showpage 
            doc.image next_page_file(doc) if i != dimensions_total
          end
        end
      end

      dimension_graphic_y_points = [0, 10, 12.5, 12.5, 12, 11, 12.5, 12.5, 11, 13.5, 12.5, 12.5]

      (1..dimensions_total).each do |i|

        dimension = Dimension.first(:conditions => "service_level_id = #{service_level_id} AND number = #{i}")
        doc.image next_page_file(doc)
        file = File.join(TEMP_DIRECTORY,"#{school_id}_#{service_level_id}_#{i}_ue_dimension_graphic.jpg")
        puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

        doc.image file, :x => 1.6, :y => dimension_graphic_y_points[i], :zoom => 55
        doc.showpage

        
        doc.image next_page_file(doc)
        graphics = 0
        indicators = Indicator.all(:conditions => "dimension_id = #{dimension.id}", :order => "number ASC").collect(&:number)
        count = 0


        indicators.each do |indicator|
          case graphics
            when 0
              y = 20.4
            when 1
              y = 14
            when 2
              y = 7.5
            when 3
              y = 1
          end
          
          
          file = File.join(TEMP_DIRECTORY,"#{school_id}_#{service_level_id}_#{i}_#{indicator}_ue_indicator_graphic.jpg")
          puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)

          doc.image file, :x => 3, :y => y, :zoom => 45

          graphics += 1
          count += 1

          if graphics >= 4
            add_index(doc) if count > 4
            doc.showpage
            graphics = 0
          end

        end
        
        if graphics != 0 && indicators.count > 4
          add_index(doc)
          doc.showpage
        end

        if graphics < 4 && indicators.count < 4
          doc.showpage
        end


        question_y_points = [0, 9, 9, 6, 9, 9, 9, 9, 9, 9, 9, 9]
        
        
        doc.image next_page_file(doc)
        file = File.join(TEMPLATE_DIRECTORY,"#{school_id}_#{service_level_id}_#{i}_questoes.jpg")
        doc.image file, :x => 1.6, :y => question_y_points[i], :zoom => 50
        doc.showpage

        doc.image next_page_file(doc)
        file = File.join(TEMPLATE_DIRECTORY,"#{school_id}_#{service_level_id}_#{i}_praticas.jpg")
        doc.image file, :x => 1.6, :y => 20.5, :zoom => 50
        doc.next_page 

        # doc.image next_page_file(doc)
        # doc.next_page 
        
      end

      doc.image next_page_file(doc)
      doc.next_page 

      doc.image next_page_file(doc)
      file = File.join(TEMPLATE_DIRECTORY,"#{school_id}_#{service_level_id}_index.jpg")
      doc.image file, :x => 1.6, :y => 9, :zoom => 50
      doc.next_page 

      doc.image next_page_file(doc)
      
      file_name = school.name.gsub(/[^a-z0-9çâãáàêẽéèîĩíìõôóòũûúù' ']+/i, '').gsub(' ', '_').downcase

      doc.render :pdf, :debug => true, :quality => :prepress,
          :filename => File.join(PUBLIC_DIRECTORY,"#{file_name}_#{@type}.pdf"),
          :logfile => File.join(TEMP_DIRECTORY,"relatorio_individual.log")
    end


  def dimension_graphic(school_id, service_level_id, dimension_number)
    school = School.find(school_id)
    dimension = Dimension.first(:conditions => "number = #{dimension_number} AND service_level_id = #{service_level_id}")
    
    school_data = ReportData.find_by_sql("
      SELECT s.name, ROUND(AVG(media),1) as calculated_media FROM report_data r
      INNER JOIN segments s ON s.id = r.segment_id
      WHERE r.school_id = #{school_id} AND r.service_level_id = #{service_level_id} AND r.dimension_id = #{dimension.id}
        AND media >= 0 AND media <= 5
      GROUP BY s.name")

    labels = ReportData.get_labels(school_data)

    school_values = ReportData.get_segments_values_for_dimension_graphic(labels, school_data)  

    values = []
    values << ["Média UE", school_values]
    


    g = Gruff::Bar.new("900x500")
    g.title = get_dimension_graphic_title(service_level_id, dimension)

    i_color = 0
    values.each do |v|
      g.data(v.first, v.last, ReportData::COLORS[i_color])
      i_color += 1
    end
    
    g.data(" ", Array.new(values.count, 0), "#fff")

    
    g.theme = {
            :marker_color => 'white',
            :background_colors => 'white'
          }

    ReportData::DEFAULT_PARAMS.each {|k, v| g.instance_variable_set("@#{k}", v)}
    
    label_number = 0
    labels.each do |l|
      if l == 'Coordenadores pedagógicos'
        l = 'Coord. ped.'
      end
      puts l
      g.labels[label_number] = l
      label_number += 1
    end
    g.labels[labels.length] = "Média Geral"

    
    g.write("#{Rails.root.to_s}/tmp/#{school_id}_#{service_level_id}_#{dimension_number}_ue_dimension_graphic.jpg")
  end

  def get_dimension_graphic_title(service_level_id, dimension)
    service_level = ServiceLevel.find(service_level_id)
    title = "Dimensão #{dimension.number}. #{dimension.name}"
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

  def indicator_graphic(school_id, service_level_id, dimension_number, indicator_number)
    school = School.find(school_id)
    dimension = Dimension.first(:conditions => "number = #{dimension_number} AND service_level_id = #{service_level_id}")
    indicator = Indicator.first(:conditions => "number = #{indicator_number} AND dimension_id = #{dimension.id}")
    
    school_data = ReportData.find_by_sql("
      SELECT s.name, media  as calculated_media FROM report_data r
      INNER JOIN dimensions d ON r.dimension_id = d.id
      INNER JOIN indicators i ON r.indicator_id = i.id
      INNER JOIN segments s ON r.segment_id = s.id
      WHERE r.school_id = #{school_id} AND r.service_level_id = #{service_level_id}
      AND d.number = #{dimension_number} AND i.number = #{indicator_number}
      AND media >= 0 AND media <= 5
      GROUP BY s.name")

    labels = ReportData.get_labels(school_data)

    school_values = ReportData.get_segments_values_for_dimension_graphic(labels, school_data)

    values = []
    values << ["Média UE", school_values]


    g = Gruff::Bar.new("900x380")
    g.title = ReportData.get_indicator_graphic_title(dimension, indicator)

    i_color = 0
    values.each do |v|
      g.data(v.first, v.last, ReportData::COLORS[i_color])
      i_color += 1
    end
    puts values.inspect
    puts labels.inspect
    g.data(" ", Array.new(values.count, 0), "#fff")

    
    g.theme = {
            :marker_color => 'white',
            :background_colors => 'white'
          }

    ReportData::DEFAULT_PARAMS.each {|k, v| g.instance_variable_set("@#{k}", v)}
    
    label_number = 0
    labels.each do |l|
      g.labels[label_number] = l
      label_number += 1
    end
    g.labels[labels.length] = "Média Geral"

    
    g.write("#{Rails.root.to_s}/tmp/#{school_id}_#{service_level_id}_#{dimension_number}_#{indicator_number}_ue_indicator_graphic.jpg")
  end

  def question_table(school_id, service_level_id, dimension_number)
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
      
      answers = Answer.find_by_sql("SELECT *, s.name as segment_name FROM answers a
        INNER JOIN question_texts qt ON a.question_text_id = qt.id
        INNER JOIN segments s ON a.segment_id = s.id
        WHERE a.school_id = #{school_id}
        AND s.id IN (SELECT id FROM segments WHERE service_level_id = #{service_level_id})
        AND qt.question_number = '#{q.question_number}'")

      total = 0
      table_data[q.question_number] = Hash.new

      answers.each do |a|
        do_not_answer = (a.do_not_answer == nil)? 0 : a.do_not_answer

        table_data[q.question_number][a.segment_name] = [a.media, do_not_answer]
        total += a.media if a.media.class != String
      end

      if (answers.count == 0 || total == 0)
        table_data[q.question_number]['Média geral da questão'] = '-'
      else
        table_data[q.question_number]['Média geral da questão'] = (total/answers.count).try(:round, 1)
      end

    end
    table_data
  end

  def generate_question_table(school_id, service_level_id, dimension_number)
    @school_id = school_id
    @service_level_id = service_level_id
    @dimension_number = dimension_number
    data = question_table(school_id, service_level_id, dimension_number)

    question_numbers = QuestionText.find_by_sql("
      SELECT DISTINCT question_number FROM question_texts
      WHERE dimension_id IN (SELECT id FROM dimensions WHERE service_level_id = #{service_level_id} AND number = #{dimension_number})
      ORDER BY SUBSTRING_INDEX( question_number , '.', 1 ) + 0,
      SUBSTRING_INDEX(SUBSTRING_INDEX( question_number , '.', 2 ), '.', -1) + 0,
      SUBSTRING_INDEX( question_number , '.', -1 ) + 0")
    questions = question_numbers.collect(&:question_number)

    @segments = ['Trabalhadores', 'Gestores', 'Familiares']

    build_question_table_html(questions, data)
    html_file = File.new(File.join(TEMP_DIRECTORY,"#{@school_id}_#{@service_level_id}_#{@dimension_number}_questoes.html"))
    IPF::TableGenerator.convert_html_to_jpg(html_file, "#{@school_id}_#{@service_level_id}_#{@dimension_number}_questoes")
  end

  def generate_index_table(school_id, service_level_id)
    @school_id = school_id
    @service_level_id = service_level_id
    dimensions = Dimension.all(:conditions => "service_level_id = #{service_level_id}")
    data = ReportData.index_table_data(school_id, service_level_id)

    @segments = ['Trabalhadores', 'Gestores', 'Familiares']
    
    build_index_table_html(dimensions, data)
    html_file = File.new(File.join(TEMP_DIRECTORY,"#{@school_id}_#{@service_level_id}_index.html"))
    IPF::TableGenerator.convert_html_to_jpg(html_file, "#{@school_id}_#{@service_level_id}_index")
  end

  def build_question_table_html(questions, data)
    header = ''
    html_code = <<HEREDOC
      <!DOCTYPE html>
      <html lang='pt-BR'>
      <head>
      <meta charset='utf-8'>

      <style type="text/css">
        #container{
          float: left;
          height: 1000px;
          position: absolute;
        }
        table {border:1px solid black; border-collapse: collapse;}
        th {background-color: #E5E5E5; border:1px solid black;}
        tr {border:1px solid black;}
        td {border:1px solid black; padding:3px; text-align:center;}
        .break_page {}
        h4{font-size:16px;}
        .nr{background-color: #7990DA;}
        li{font-size:11px; width:87%; text-align: justify;}
        .note{margin-top: 15px;font-size:11px; width:87%; text-align: justify;}
      </style>

      </head>
      <body>
      <div id = 'container'>
      <table width='100%'>
        <tr>
          <th>Questão</th>
HEREDOC

    @segments.each do |d|
      html_code << "<th colspan = 2> #{d} </th>"
    end
    html_code << <<-HEREDOC
      <th>Média geral</br> da questão</th>
HEREDOC
    html_code << '</tr>'
  
    html_code << <<-HEREDOC
      <tr>
        <th></th>
        <th>média</th>
        <th>Não respondeu</br>(Ø)</th>
        <th>média</th>
        <th>Não respondeu</br>(Ø)</th>
        <th>média</th>
        <th>Não respondeu</br>(Ø)</th>
        <th></th>
      </tr>
HEREDOC

    questions.each do |q|
      html_code << '<tr>'
      html_code << "<td>#{q}</td>"
      @segments.each do |s|
        segment = Segment.first(:conditions => "name = '#{s}' AND service_level_id = #{@service_level_id}")
        question_text = QuestionText.first(:conditions => "question_number = '#{q}' AND segment_id = #{segment.id}")
        if question_text.nil?
          html_code << "<td>-</td>"
          html_code << "<td class='nr'>-</td>"
        elsif data[q].nil? || data[q][s].nil?
          html_code << "<td>S/R</td>"
          html_code << "<td class='nr'>S/R</td>"
        else
          html_code << "<td>#{data[q][s].first}</td>"
          html_code << "<td class='nr'>#{data[q][s].last}</td>"
        end
      end

      ['Média geral da questão'].each do |s|
        html_code << "<td>#{data[q][s]}</td>"
      end
      html_code << '</tr>'
    end
    html_code << <<-HEREDOC
      </table>
      <div>
        <p>
          *    o símbolo (-) sinaliza que a pergunta não era pertinente ao segmento
        </p>
        <p>
          * *  a sigla S/R (sem resposta) sinaliza que não foram inseridos dados no sistema online 
        </p>
      </div>
    </div>
HEREDOC

    html_file = File.new(File.join(TEMP_DIRECTORY,"#{@school_id}_#{@service_level_id}_#{@dimension_number}_questoes.html"), 'w+')
    html_file.puts html_code
    html_file.close
    html_file
  end


  def build_index_table_html(dimensions, data)
    header = ''
    html_code = <<HEREDOC
      <!DOCTYPE html>
      <html lang='pt-BR'>
      <head>
      <meta charset='utf-8'>

      <style type="text/css">
        #container{
          float: left;
          height: 1000px;
          position: absolute;
        }
        table {border:1px solid black; border-collapse: collapse;}
        th {background-color: #E5E5E5; border:1px solid black;}
        tr {border:1px solid black;}
        td {border:1px solid black; padding:2px; text-align:center;}
        .break_page {}
        h4{font-size:16px;}
        .nr{background-color: #7990DA;}
        li{font-size:11px; width:87%; text-align: justify;}
        .note{margin-top: 15px;font-size:11px; width:87%; text-align: justify;}
      </style>

      </head>
      <body>
      <div id = 'container'>
      <table width='100%'>
        <tr>
          <td style='text-align: left'>
            O índice geral da sua unidade em 2011, obtido com base na média dos índices de cada dimensão é: #{data['index']}
          </td>
        
        </tr>
      </table>
      <div style='height: 40px; float:left; width: 100%;'></div>
      <table width='100%'>
        <tr>
          <th>Dimensões</th>
          <th colspan = #{@segments.count} >Dimensões</th>
          <th>Índice da unidade</th>
        </tr>
        <tr>
HEREDOC

    
    html_code << "<th> </th>"
    @segments.each do |d|
      html_code << "<th> #{d} </th>"
    end
    html_code << "<th> </th>"
    html_code << '</tr>'

    dimensions.each do |d|
      html_code << '<tr>'
      html_code << "<td style='text-align: left'>#{d.number}. #{data[d.number]['name']}</td>"
      @segments.each do |s|
        if data[d.number][s].nil?
          html_code << "<td>-</td>"
        else
          html_code << "<td>#{data[d.number][s]}</td>"
        end
      end
      
      html_code << "<td>#{data[d.number]['index']}</td>"
    
      html_code << '</tr>'
    end

    html_code << <<-HEREDOC
      <tr>
        <td style='text-align: left'> Índice Geral por segmento/unidade </td>
      
HEREDOC

    @segments.each do |s|
      html_code << "<td> #{data[s]} </td>"
    end
    html_code << "<td> #{data['index']} </td></tr>"

    html_code << <<-HEREDOC
      </table>
    </div>
HEREDOC

    html_file = File.new(File.join(TEMP_DIRECTORY,"#{@school_id}_#{@service_level_id}_index.html"), 'w+')
    html_file.puts html_code
    html_file.close
    html_file
  end

  private
    def inc_page
      @inc_page ||= 0
      @inc_page += 1
    end

    def next_page_file(doc, index=true)
      page_file(inc_page, doc, index)
    end

    def page_file(pg_no, doc, index=true)
      add_index(doc, index)
      file = File.join("#{TEMPLATE_DIRECTORY}/#{@type}","pg_%04d.eps" % pg_no)
      puts "ARQUIVO NAO EXISTE: #{file}" if !File.exists?(file)
      file
    end

    def add_index(doc, index=true)
      @index ||= 2
      if @index.even?
        doc.show "#{@index}", :with => :index, :align => :page_left if index        
      else
        doc.show "#{@index}", :with => :index, :align => :page_right if index
      end
      @index += 1
    end

  end
end