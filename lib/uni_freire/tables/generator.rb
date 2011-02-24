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
                  11 => "11. Processos de Alfabetização e Letramento"
                  }

      def self.generate(service_level)
        data = get_data(service_level)
        institutions = get_institutions(data)
        dimensions = get_dimensions(data)
        build_legends(institutions, "Unidades Escolares #{service_level.name}")
        build_html(data,institutions, dimensions)
        table_file = File.new(File.join(TEMP_DIRECTORY,'tabela.html'))
        legends_file = File.new(File.join(TEMP_DIRECTORY,'legenda.html'))
        convert_html_to_pdf(table_file, "tabela_#{service_level.name}")
        convert_html_to_pdf(legends_file, "legenda_#{service_level.name}")
      end

      def self.build_legends(institutions, title)
        html_code = get_initial_html
        html_code << "<h5>#{title}</h5>
                      <table>"
        institutions.each do |i|
          html_code << "
            <tr>
              <td style=\"font-size:11px\">#{i[1]}</td>
              <td style=\"width:auto;font-size:11px\">#{i[0]}</td>
            </tr>"
        end
        html_code << '</table></body></html>'
        create_html_file(html_code, 'legenda.html')
      end

      def self.build_html(data,institutions, dimensions)
        columns_size = 60
        html_code = get_initial_html
        first_table = '<table>'
        second_table = '<table>'
        first_header = ''
        second_header = ''

        [first_table, second_table, first_header, second_header].each do |s|
          s << <<HEREDOC
           <tr>
            <td class = "first_column" style= "text-align:center;" rowspan = "3"> Dimensão </td>
           </tr>
           <tr>
            <td colspan = \"#{institutions.count}\"> Unidade Escolar </td>
           </tr>
           <tr>
HEREDOC
        end

        institutions.size.times do |i|
          if i > columns_size
            [second_table, second_header].each {|s| s << "<td> #{institutions[i][1]} </td>"}
          else
            [first_table, first_header].each {|s| s << "<td> #{institutions[i][1]} </td>"}
          end
        end

        [first_table, second_table, first_header, second_header].each {|s| s << "</tr>"}

        dimensions.each do |dimension|
          [first_table, second_table].each {|s| s << "<tr> <td class = \"first_column\"> #{DIMENSION[dimension]} </td>"}
          institutions_columns_control = 0

          institutions.each do |institution|
            institutions_columns_control += 1
            if institutions_columns_control > columns_size
              second_table = add_data_in_table(data, institution[0], dimension, second_table)
            else
              first_table = add_data_in_table(data, institution[0], dimension, first_table)
            end
          end

          [first_table, second_table].each {|s| s << "</tr>"}
        end

        if institutions.count > columns_size
          first_table << "</table> <div class=\"break_page\"> </div>"
        end
        second_table << "</table>"
        html_code << first_table
        html_code << second_table if institutions.count > columns_size
        create_html_file(html_code, 'tabela.html')
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

      def self.get_data(service_level)
        data = {}
        institutions = service_level.institutions
        dimensions = Dimension.all
        dimensions.each do |dimension|
          institutions.each do |institution|
            data[institution.name] = {} if data[institution.name].nil?
            value = (institution.mean_dimension(dimension,service_level)[:mean]/5)
            value = (value == 0)? value : value.round(2)
            data[institution.name][dimension.number] = value
          end
        end
        data
      end

      def self.get_dimensions(data)
        institution_id = data.keys.first
        data[institution_id].keys.sort!
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
          table{border:1px solid black;
                border-collapse: collapse;}
          tr{border:1px solid black;}
          td{border:1px solid black;
             width:15px;padding:2px;
             text-align:center;
             font-size: 8px;
             }
          h5{font-size:12px;}
          .red{background-color:red}
          .yellow{background-color:yellow}
          .green{background-color:green}
          .space_betweet_tables{height:20px;}
          .first_column{
            border: 1px solid black;
            width: 420px;
            padding: 2px;
            text-align: left;
            font-size: 8px;
          }
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

