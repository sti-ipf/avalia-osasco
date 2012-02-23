module IPF
  class ColorTable

    TEMP_DIRECTORY = File.expand_path "#{RAILS_ROOT}/tmp"
    DIMENSION = {
                  1 => "1. Ambiente Educativo",
                  2 => "2. Ambiente Físico Escolar e Materiais",
                  3 => "3. Planejamento Institucional e Prática Pedagógica",
                  4 => "4. Avaliação",
                  5 => "5. Acesso e Permanência dos Educandos na Escola",
                  6 => "6. Promoção da Saúde",
                  7 => "7. Educação Socioambiental e Práticas Pedagógicas",
                  8 => "8. Envolvimento com as Famílias e Participação na Rede de Proteção Social",
                  9 => "9. Gestão Escolar Democrática",
                  10 => "10. Formação e Condições de Trabalho dos Profissionais da Escola",
                  11 => "11. Processos de Alfabetização e Letramento",
                  12 => "Índice geral da unidade"
                  }

    def self.generate(with_grades=false)
      service_levels = ServiceLevel.all(:conditions => "id NOT IN (5)")
      service_levels.each do |service_level|
        legend_file_name = "#{service_level.name}_legend"
        table_file_name = "#{service_level.name}_table"
        data = get_data(service_level)
        schools = get_schools(data)
        dimensions = service_level.dimensions
        if with_grades
          case service_level.id
            when 2
              title = "<div><h5>Anexo 2 - Quadro dos índices das unidades por dimensões: Ensino Fundamental</h5></div>
                <div>Unidades Escolares #{service_level.name}</div>"
            when 3
              title = "<div><h5>ANEXO 1 - Quadro dos índices das unidades por dimensões com os índices: Educação Infantil</h5></div>
                <div>Unidades Escolares #{service_level.name}</div>"
            when 4
              title = "Unidades Escolares #{service_level.name}"
            end
        else
          title = "Unidades Escolares #{service_level.name}"
        end
        build_legends(schools, title, legend_file_name)
        build_html(data,schools, dimensions, table_file_name, with_grades)
        table_file = File.new(File.join(TEMP_DIRECTORY,"#{table_file_name}.html"))
        legend_file = File.new(File.join(TEMP_DIRECTORY,"#{legend_file_name}.html"))
        IPF::TableGenerator.convert_html_to_jpg(table_file, table_file_name)
        IPF::TableGenerator.convert_html_to_jpg(legend_file, legend_file_name)
      end
    end

    def self.build_legends(schools, title, file_name)
      html_code = get_initial_html
      html_code << "<div style='font-size:16px;margin-botton:15px;'>#{title}</div>
                    <br>
                    <table>"
      break_control = 0
      schools_size = schools.size
      schools.each do |i|
        html_code << "
          <tr>
            <td style=\"font-size:14px; padding:5px;\">#{i[1]}</td>
            <td style=\"width:auto;font-size:14px; padding:3px;\">#{i[0]}</td>
          </tr>"
        break_control += 1
        # if break_control == 40 && schools_size > 50
        #   html_code << "</table> <div class=\"break_page\"> </div> <table>"
        #   break_control = 0
        # end
      end
      html_code << '</table></body></html>'
      create_html_file(html_code, "#{file_name}.html")
    end

    def self.build_html(data, schools, dimensions, file_name, with_grades)
      html_code = get_initial_html
      html_code << '<table>'
      header = ''

      [html_code, header].each do |s|
        s << "
         <tr>
          <td rowspan = '3'>Escolas</td>
         </tr>
         <tr>
          <td colspan = '#{dimensions.count+1}'> Dimensões </td>
         </tr>
         <tr>"
      end

      dimensions.each do |dimension|
        [html_code, header].each do |s|
          s << "<td>
                  #{dimension.number}. #{dimension.name}
                </td>"
        end
      end

      [html_code, header].each {|s| s << "<td> Índice geral </td>"}

      [html_code, header].each {|s| s << "</tr>"}

      schools.each do |school|
        html_code << "<tr> <td> #{school[1]} </td>"
        dimensions.each do |dimension|
          html_code = add_data_in_table(data, school[0], dimension, html_code, with_grades)
        end
        value = data[school[0]]['index']
        css_class = get_css_class(value)
        html_code << "<td class = \"#{css_class}\"> #{value} </td>"
        html_code << "</tr>"
      end
      html_code << "</table></body></html>"
      create_html_file(html_code, "#{file_name}.html")
    end

  private

    def self.get_schools(data)
      schools_temp = data.keys.sort
      schools = []
      schools_temp.size.times do |i|
        schools << [schools_temp[i], (i+1)]
      end
      schools
    end

    def self.get_data(service_level)
      data = {}
      schools = service_level.schools
      dimensions = service_level.dimensions
      schools.each do |school|
        data[school.name] = ReportData.index_table_data(school.id, service_level.id)
      end
      data
    end

    def self.calc_school_index(school_dimensions_values)
      sum_values = 0
      school_dimensions_values.each do |value|
          sum_values += value
      end
      index = (sum_values/school_dimensions_values.size)
      index = (index == 0)? index : index.round(2)
    end

    def self.add_data_in_table(data, school, dimension, table, with_grades)
      number_filled = false
      
      begin
        value = data[school][dimension.number]['index']
        if !value.nil?
          if !with_grades
            css_class = get_css_class(value)
            table << "<td class = \"#{css_class}\"> #{value} </td>"
          else
            table << "<td> #{value} </td>"
          end
          number_filled = true
        end
      rescue
      end
      table << "<td> - </td>" if number_filled == false
      table
    end

    def self.get_css_class(value)
      if value.between?(0, 0.33)
        "red"
      elsif value.between?(0.34, 0.66)
        "yellow"
      else value.between?(0.67, 1)
        "green"
      end
    end

    def self.convert_html_to_pdf(html_file, file_name)
      kit = PDFKit.new(html_file)
      kit.to_pdf
      pdf_file = File.join(TEMP_DIRECTORY,"#{file_name}.pdf")
      kit.to_file(pdf_file)
      pdf_file
    end

    def self.get_initial_html
      <<HEREDOC
      <!DOCTYPE html>
      <html lang='pt-BR'>
      <head>
      <meta charset='utf-8'>
      <style type="text/css">
        @font-face {
          font-family: PTSans;
          src: local("#{RAILS_ROOT}/public/fonts/PT_Sans-Regular.ttf")
        }

        @font-face {
          font-family: PTSans;
          src: local("#{RAILS_ROOT}/public/fonts/PT_Sans-Bold.ttf")
          font-weight: bold;
        }

        @font-face {
          font-family: PTSans;
          src: local("#{RAILS_ROOT}/public/fonts/PT_Sans-Italic.ttf")
          font-weight: italic;
        }

        body {font-family: PTSans;font-size:16px;}
        table{border:1px solid black; border-collapse: collapse;}
        tr{border:1px solid black;}
        td{border:1px solid black;
           width:auto;
           padding:1px;
           text-align:center;
           font-size: 16px;
           }
        h5{font-size:16px; font-weight:bold}
        .red{background-color:red}
        .yellow{background-color:yellow}
        .green{background-color:green}
        .space_betweet_tables{height:20px;}
        .break_page {}
        @media print {
          .break_page { page-break-after: always;}
        }
      </style>

      </head>
      <body>
HEREDOC
    end

    def self.create_html_file(html_code, file_name)
      html_file = File.new(File.join(TEMP_DIRECTORY,file_name), 'w+')
      html_file.puts html_code
      html_file.close
    end
  end
end