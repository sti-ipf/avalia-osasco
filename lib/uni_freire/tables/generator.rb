module UniFreire
  module Tables
    class Generator
      TEMP_DIRECTORY = File.expand_path "#{RAILS_ROOT}/tmp"
      DIMENSION = {
                  1 => "1. Ambiente Educativo",
                  2 => "2. Ambiente Físico Escolar e Materiais",
                  3 => "3. Planejamento Institucional e Prática Pedagógica",
                  4 => "4. Avaliação",
                  5 => "5. Acesso e Permanência dos Educandos na Escola",
                  6 => "6. Promoção da Saúde",
                  7 => "7. Educação Sócio Ambiental e Práticas Pedagógicas",
                  8 => "8. Envolvimento com as Famílias e Participação na Rede de Proteção Social",
                  9 => "9. Gestão Escolar Democrática",
                  10 => "10. Formação e Condições de Trabalho dos Profissionais da Escola",
                  11 => "11. Processos de Alfabetização e Letramento",
                  12 => "Índice geral da unidade"
                  }

      def self.generate(service_level)
        legend_file_name = "#{service_level.name}_legend"
        table_file_name = "#{service_level.name}_table"
        data = get_data(service_level)
        institutions = get_institutions(data)
        dimensions = get_dimensions(data)
        build_legends(institutions, "Unidades Escolares #{service_level.name}", legend_file_name)
        build_html(data,institutions, dimensions, table_file_name)
        table_file = File.new(File.join(TEMP_DIRECTORY,"#{table_file_name}.html"))
        legend_file = File.new(File.join(TEMP_DIRECTORY,"#{legend_file_name}.html"))
        convert_html_to_pdf(table_file, table_file_name)
        convert_html_to_pdf(legend_file, legend_file_name)
      end

      def self.build_legends(institutions, title, file_name)
        html_code = get_initial_html
        html_code << "<h5>#{title}</h5>
                      <table>"
        break_control = 0
        institutions_size = institutions.size
        institutions.each do |i|
          html_code << "
            <tr>
              <td style=\"font-size:11px\">#{i[1]}</td>
              <td style=\"width:auto;font-size:11px\">#{i[0]}</td>
            </tr>"
          break_control += 1
          if break_control == 40 && institutions_size > 50
            html_code << "</table> <div class=\"break_page\"> </div> <table>"
            break_control = 0
          end
        end
        html_code << '</table></body></html>'
        create_html_file(html_code, "#{file_name}.html")
      end

      def self.build_html(data,institutions, dimensions, file_name)
        html_code = get_initial_html
        html_code << '<table>'
        header = ''

        [html_code, header].each do |s|
          s << <<HEREDOC
           <tr>
            <td rowspan = "3"> Unidade Escolar </td>
           </tr>
           <tr>
            <td colspan = \"#{dimensions.count}\"> Dimensões </td>
           </tr>
           <tr>
HEREDOC
        end

        dimensions.each do |dimension|
          [html_code, header].each do |s|
            s << "<td>
                    #{DIMENSION[dimension]}
                  </td>"
          end
        end

        [html_code, header].each {|s| s << "</tr>"}

        institutions.each do |institution|
          html_code << "<tr> <td> #{institution[1]} </td>"
          dimensions.each do |dimension|
            html_code = add_data_in_table(data, institution[0], dimension, html_code)
          end
          html_code << "</tr>"
        end
        html_code << "</table></body></html>"
        create_html_file(html_code, "#{file_name}.html")
      end

    private

      def self.get_institutions(data)
        institutions_temp = data.keys.sort
        institutions = []
        institutions_temp.size.times do |i|
          institutions << [institutions_temp[i], (i+1)]
        end
        institutions
      end

      def self.get_dimensions(data)
        institution_id = data.keys.first
        data[institution_id].keys.sort!
      end

      def self.get_data(service_level)
        data = {}
        institutions = service_level.institutions
        dimensions = Dimension.all
        dimensions << Dimension.new(:name => "Índice geral da unidade", :number => 12)
        institutions.each do |institution|
          data[institution.name] = {}
          institution_dimensions_values = []
          dimensions.each do |dimension|
            if dimension.number == 11 && service_level.name != "EMEF"
              next
            end
            if dimension.number == 12
              institution_index = calc_institution_index(institution_dimensions_values)
              data[institution.name][dimension.number] = institution_index
            else
              value = (institution.mean_dimension(dimension,service_level)[:mean]/5)
              value = (value == 0)? value : value.round(2)
              data[institution.name][dimension.number] = value
              institution_dimensions_values << value
            end
          end
        end
        data
      end

      def self.calc_institution_index(institution_dimensions_values)
        sum_values = 0
        institution_dimensions_values.each do |value|
            sum_values += value
        end
        index = (sum_values/institution_dimensions_values.size)
        index = (index == 0)? index : index.round(2)
      end

      def self.add_data_in_table(data, institution, dimension, table)
        number_filled = false
        begin
          value = data[institution][dimension]
          if !value.nil?
            css_class = get_css_class(value)
            table << "<td class = \"#{css_class}\"> </td>"
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

          body {font-family: PTSans;}
          table{border:1px solid black; border-collapse: collapse;}
          tr{border:1px solid black;}
          td{border:1px solid black;
             width:auto;
             padding:1px;
             text-align:center;
             font-size: 8px;
             }
          h5{font-size:12px; font-weight:bold}
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

    end #Generator
  end #Tables
end #UniFreire

