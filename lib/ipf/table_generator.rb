module IPF
  class TableGenerator

    TEMPLATE_DIRECTORY= File.expand_path "#{RAILS_ROOT}/lib/templates"
    TEMP_DIRECTORY = File.expand_path "#{RAILS_ROOT}/tmp"
    PUBLIC_DIRECTORY = File.expand_path "#{RAILS_ROOT}/public"

    def self.generate_question_table(school_id, service_level_id, dimension_number)
      @school_id = school_id
      @service_level_id = service_level_id
      @dimension_number = dimension_number
      data = ReportData.question_table(school_id, service_level_id, dimension_number)

      question_numbers = QuestionText.find_by_sql("
        SELECT DISTINCT question_number FROM question_texts
        WHERE dimension_id IN (SELECT id FROM dimensions WHERE service_level_id = #{service_level_id} AND number = #{dimension_number})
        ORDER BY SUBSTRING_INDEX( question_number , '.', 1 ) + 0,
        SUBSTRING_INDEX(SUBSTRING_INDEX( question_number , '.', 2 ), '.', -1) + 0,
        SUBSTRING_INDEX( question_number , '.', -1 ) + 0")
      questions = question_numbers.collect(&:question_number)

      if [3].include?(service_level_id)
        @segments = ['Professores', 'Gestores', 'Funcionários', 'Familiares', 'Educandos']
      elsif service_level_id == 4
        @segments = ['Professores', 'Gestores', 'Funcionários', 'Educandos']
      elsif service_level_id == 5
        @segments = ['Trabalhadores', 'Gestores', 'Familiares']
      elsif service_level_id == 6
        @segments = ['Gestores', 'Coordenadores pedagógicos', 'Professores', 'Funcionários', 'Familiares']
      else
        @segments = ['Professores', 'Gestores', 'Funcionários', 'Familiares']
      end

      if [3, 6].include?(service_level_id)
        educandos = true
      else
        educandos = false
      end

      build_question_table_html(questions, data, educandos)
      html_file = File.new(File.join(TEMP_DIRECTORY,"#{@school_id}_#{@service_level_id}_#{@dimension_number}_questoes.html"))
      convert_html_to_jpg(html_file, "#{@school_id}_#{@service_level_id}_#{@dimension_number}_questoes")
    end

    def self.generate_index_table(school_id, service_level_id)
      @school_id = school_id
      @service_level_id = service_level_id
      dimensions = Dimension.all(:conditions => "service_level_id = #{service_level_id}")
      data = ReportData.index_table_data(school_id, service_level_id)

      if [3].include?(service_level_id)
        @segments = ['Professores', 'Gestores', 'Funcionários', 'Familiares', 'Educandos']
      elsif service_level_id == 4
        @segments = ['Professores', 'Gestores', 'Funcionários', 'Educandos']
      elsif service_level_id == 5
        @segments = ['Trabalhadores', 'Gestores', 'Familiares']
      elsif service_level_id == 6
        @segments = ['Gestores', 'Coordenadores pedagógicos', 'Professores', 'Funcionários', 'Familiares'] 
      else
        @segments = ['Professores', 'Gestores', 'Funcionários', 'Familiares']
      end

      if [3, 6].include?(service_level_id)
        educandos = true
      else
        educandos = false
      end
      
      build_index_table_html(dimensions, data, educandos)
      html_file = File.new(File.join(TEMP_DIRECTORY,"#{@school_id}_#{@service_level_id}_index.html"))
      convert_html_to_jpg(html_file, "#{@school_id}_#{@service_level_id}_index")
    end

    def self.generate_practices_table(school_id, service_level_id, dimension_number)
      @school_id = school_id
      @service_level_id = service_level_id
      @dimension_number = dimension_number
      dimension = Dimension.first(:conditions => "number = #{@dimension_number} AND service_level_id = #{@service_level_id}")
      practices = Practice.find_by_sql("SELECT consolidated, to_be_improved, s.name FROM practices p
        INNER JOIN segments s ON p.segment_id = s.id
        WHERE p.school_id = #{school_id} AND p.dimension_id = #{dimension.id} AND
        p.segment_id IN
        (SELECT id FROM segments WHERE service_level_id = #{service_level_id})
        ORDER BY name")
      data = Hash.new
      rows_size = 0
      name = nil

      if [3].include?(service_level_id)
        @segments = ['Professores', 'Gestores', 'Funcionários', 'Familiares', 'Educandos']
      elsif service_level_id == 4
        @segments = ['Professores', 'Gestores', 'Funcionários', 'Educandos']
      elsif service_level_id == 5
        @segments = ['Trabalhadores', 'Gestores', 'Familiares']
      elsif service_level_id == 6
        @segments = ['Gestores', 'Coordenadores pedagógicos', 'Professores', 'Funcionários', 'Familiares']
      else
        @segments = ['Professores', 'Gestores', 'Funcionários', 'Familiares']
      end

      if [3, 6].include?(service_level_id)
        educandos = true
      else
        educandos = false
      end

      @segments.each do |s|
        data[s] = Hash.new
        data[s]['consolidated'] = []
        data[s]['to_be_improved'] = []
      end

      practices.each do |p|
        name ||= p.name

        if name != p.name
          consolidated_size = data[name]['consolidated'].count
          to_be_improved_size = data[name]['to_be_improved'].count
          rows_size = consolidated_size if rows_size < consolidated_size 
          rows_size = to_be_improved_size if rows_size < to_be_improved_size 
          name = p.name
        end

        data[name]['consolidated'] << p.consolidated if !p.consolidated.nil?
        data[name]['to_be_improved'] << p.to_be_improved if !p.to_be_improved.nil?

      end
      
      build_practices_table_html(data, rows_size, educandos)
      html_file = File.new(File.join(TEMP_DIRECTORY,"#{@school_id}_#{@service_level_id}_#{@dimension_number}_praticas.html"))
      convert_html_to_jpg(html_file, "#{@school_id}_#{@service_level_id}_#{@dimension_number}_praticas")
    end

    def self.build_question_table_html(questions, data, educandos)
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
        if @service_level_id == 6
          if d == 'Gestores'
            d = 'Gerentes'
          end
        end
        html_code << "<th colspan = 2> #{d} </th>"
      end
      html_code << <<-HEREDOC
        <th>Média geral</br> da questão</th>
        <th>Média por</br> agrupamento</th>
        <th>Média da</br> rede</th>
HEREDOC
      html_code << '</tr>'

      if educandos      
        html_code << <<-HEREDOC
          <tr>
            <th></th>
            <th>média</th>
            <th>Não respondeu</br>(Ø)</th>
            <th>média</th>
            <th>Não respondeu</br>(Ø)</th>
            <th>média</th>
            <th>Não respondeu</br>(Ø)</th>
            <th>média</th>
            <th>Não respondeu</br>(Ø)</th>
            <th>média</th>
            <th>Não respondeu</br>(Ø)</th>
            <th></th>
            <th></th>
            <th></th>
          </tr>
HEREDOC
      else
        html_code << <<-HEREDOC
          <tr>
            <th></th>
            <th>média</th>
            <th>Não respondeu</br>(Ø)</th>
            <th>média</th>
            <th>Não respondeu</br>(Ø)</th>
            <th>média</th>
            <th>Não respondeu</br>(Ø)</th>
            <th>média</th>
            <th>Não respondeu</br>(Ø)</th>
            <th></th>
            <th></th>
            <th></th>
          </tr>
HEREDOC
      end
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

        ['Média geral da questão', 'Média por agrupamento', 'Média da rede'].each do |s|
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

    def self.build_practices_table_html(data, rows_size, educandos)
      header = ''
      html_code = <<HEREDOC
        <!DOCTYPE html>
        <html lang='pt-BR'>
        <head>
        <meta charset='utf-8'>

        <style type="text/css">
          #container{
            float: left;
            height: 350px;
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
            <th>Segmento</th>
            <th>Práticas consolidadas</th>
            <th>Práticas que precisam avançar</th>
          </tr>

HEREDOC
      
      @segments.each do |s|
        rows_size.times do |i|
          ss = s
          if @service_level_id == 6
            if ss == 'Gestores'
              ss = 'Gerentes'
            end
          end
          html_code << '<tr>'
          html_code << "<td>#{ss}</td>"
          if data[s]['consolidated'][i].nil?
            html_code << "<td></td>"
          else
            html_code << "<td>#{data[s]['consolidated'][i]}</td>"
          end

          if data[s]['to_be_improved'][i].nil?
            html_code << "<td></td>"
          else
            html_code << "<td>#{data[s]['to_be_improved'][i]}</td>"
          end

          html_code << '</tr>'
        end
      end
      html_code << <<-HEREDOC
        </table>
      </div>
HEREDOC

      html_file = File.new(File.join(TEMP_DIRECTORY,"#{@school_id}_#{@service_level_id}_#{@dimension_number}_praticas.html"), 'w+')
      html_file.puts html_code
      html_file.close
      html_file
    end

    def self.build_index_table_html(dimensions, data, educandos)

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
        if @service_level_id == 6
          if d == 'Gestores'
            d = 'Gerentes'
          end
        end
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

    def self.convert_to_eps(html_file)
      pdf_file = convert_html_to_pdf(html_file)
      eps_file = File.join(TEMP_DIRECTORY,"#{@school_id}_#{@service_level_id}_#{@dimension_number}_questoes.pdf")
      (1..2).each do |i|
        `pdftops -eps -f #{i} -l #{i} #{pdf_file} #{eps_file}_#{i}.eps 1> /dev/null 2> /dev/null`
      end
      #`rm #{pdf_file}`
      get_eps_files_generated
    end

    def self.convert_html_to_pdf(html_file, file_name)
      kit = PDFKit.new(html_file)
      kit.to_pdf
      pdf_file = File.join(TEMPLATE_DIRECTORY,"#{file_name}.pdf")
      kit.to_file(pdf_file)
      pdf_file
    end

    def self.convert_html_to_jpg(html_file, file_name)
      kit = IMGKit.new(html_file)
      jpg_file = File.join(TEMPLATE_DIRECTORY,"#{file_name}.jpg")
      kit.to_file(jpg_file)
    end

  end
end